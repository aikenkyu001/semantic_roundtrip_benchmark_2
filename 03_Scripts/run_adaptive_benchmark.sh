#!/bin/bash
# Runs the benchmark with an adaptive strategy based on model characteristics,
# focusing on the most effective prompt combination.

# --- Usage ---
usage() {
    echo "Usage: $0 --mode <strict|forgiving|composite> [--test-case <name>] [--num-runs <int>] [model_name...]"
    echo ""
    echo "Arguments:"
    echo "  --mode <strict|forgiving|composite> : Set the evaluation mode."
    echo "  --test-case <name>                  : (Optional) Test case to run (default: process_user_list)."
    echo "  --num-runs <int>                    : (Optional) Number of runs per combination (default: 30)."
    echo "  [model_name...]                     : (Optional) Space-separated list of models to test."
    exit 1
}

# --- Argument Parsing ---
MODE=""
TEST_CASE="process_user_list"
NUM_RUNS=30
MODELS_CLI=()

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --mode) MODE="$2"; shift; shift ;;
        --test-case) TEST_CASE="$2"; shift; shift ;;
        --num-runs) NUM_RUNS="$2"; shift; shift ;;
        *) MODELS_CLI+=("$1"); shift ;;
    esac
done

# Validate arguments
if [[ -z "$MODE" ]] || [[ "$MODE" != "strict" && "$MODE" != "forgiving" && "$MODE" != "composite" ]]; then
    echo "Error: --mode must be 'strict', 'forgiving', or 'composite'."
    usage
fi

# --- Model and Language Configuration ---
MODELS_DEFAULT=(
    "gemma3:4b" "falcon3:3b" "llama3.2:3b" "llama2:7b" "yi:6b" "phi3:mini"
    "smollm:360m" "gemma3:270m" "qwen:0.5b" "qwen2.5:0.5b" "qwen3:0.6b"
    "tinyllama:1.1b" "qwen2:1.5b" "stablelm2:1.6b" "deepseek-r1:1.5b"
    "qwen:1.8b" "llama3.2:1b" "phi:latest" "gemma:2b" "smollm2:1.7b"
    "falcon3:1b" "orca-mini:3b" "qwen:4b" "deepscaler:1.5b"
)
if [ ${#MODELS_CLI[@]} -eq 0 ]; then
    MODELS=("${MODELS_DEFAULT[@]}")
else
    MODELS=("${MODELS_CLI[@]}")
fi

# --- Path and Script Setup ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
BASE_DIR=$(realpath "$SCRIPT_DIR/..")
PYTHON_SCRIPT="$BASE_DIR/03_Scripts/run_cycle_test_syntactic.py"
RUN_TYPE="adaptive_${MODE}_n${NUM_RUNS}_${TEST_CASE}"
RESULTS_DIR="$BASE_DIR/04_RawData/${RUN_TYPE}_$(date +%Y%m%d_%H%M%S)"

# --- Configuration Echo ---
echo "Starting Focused Adaptive Benchmark Run..."
echo "===================================================="
echo "Test Case:          $TEST_CASE"
echo "Mode:               $MODE"
echo "Prompt Combo:       pseudocode + hyper_guided"
echo "Models to test:     ${MODELS[@]}"
echo "Runs per test:      $NUM_RUNS"
echo "Results will be in: $RESULTS_DIR"
echo "===================================================="

mkdir -p "$RESULTS_DIR"

# --- Environment Checks ---
if [[ -z "$OLLAMA_API_URL" ]]; then
    echo "Error: OLLAMA_API_URL environment variable is not set. Exiting."
    exit 1
fi

# --- Main Execution Loop ---
# Fixed spec and style based on prior analysis
spec_lang="pseudocode"
style="hyper_guided"

for model in "${MODELS[@]}"; do
    # Adaptive Strategy: Choose language based on model name
    lang="en" # Default to English
    if [[ $model == *"gemma"* ]]; then
        lang="ja"
        echo "Model '$model' detected as a Gemma model, switching to Japanese ('ja') prompts."
    fi

    for (( i=1; i<=$NUM_RUNS; i++ )); do
        run_id="${lang}_${spec_lang}_${style}_${TEST_CASE}_run${i}"
        output_dir="$RESULTS_DIR/${model//:/-}_${run_id}"

        echo "--- STARTING: [$MODE] Test=$TEST_CASE, Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---"

        CMD_ARGS=(--model "$model" --test-case "$TEST_CASE" --spec-lang "$spec_lang" --prompt-style "$style" --lang "$lang" --output-dir "$output_dir" --api-url "$OLLAMA_API_URL" --max-cycles 10)

        if [[ "$MODE" == "composite" ]]; then
            # 1. Run with strict mode first
            echo "  Attempting with mode: strict"
            python3 "$PYTHON_SCRIPT" "${CMD_ARGS[@]}" --mode "strict"
            
            # 2. Check result and fallback to forgiving if failed
            result_file="$output_dir/result.json"
            if [[ -f "$result_file" ]] && ! grep -q "SUCCESS" "$result_file"; then
                echo "  Strict mode failed. Falling back to mode: forgiving"
                python3 "$PYTHON_SCRIPT" "${CMD_ARGS[@]}" --mode "forgiving"
            else
                echo "  Strict mode succeeded. No fallback needed."
            fi
        else
            # Run with the specified mode (strict or forgiving)
            python3 "$PYTHON_SCRIPT" "${CMD_ARGS[@]}" --mode "$MODE"
        fi

        echo "--- FINISHED: [$MODE] Test=$TEST_CASE, Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---"
        echo
    done
done

echo "Focused adaptive benchmark run completed. Results are in: $RESULTS_DIR"

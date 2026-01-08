#!/bin/bash
# A unified, parameterized script to run semantic round-trip benchmarks.

# --- Usage ---
usage() {
    echo "Usage: $0 --mode <strict|forgiving> --num-runs <integer> [model_name_1 model_name_2 ...]"
    echo ""
    echo "Arguments:"
    echo "  --mode <strict|forgiving>  : Set the test mode. 'strict' uses simple markdown parsing,"
    echo "                               'forgiving' uses AST-based syntactic parsing."
    echo "  --num-runs <integer>       : Number of times to run each test combination."
    echo "  [model_name...]            : (Optional) Space-separated list of models to test."
    echo "                               If not provided, a default list of all models will be used."
    exit 1
}

# --- Argument Parsing ---
MODE=""
NUM_RUNS=""
MODELS=()

# Parse named arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --mode)
        MODE="$2"
        shift; shift
        ;;
        --num-runs)
        NUM_RUNS="$2"
        shift; shift
        ;;
        *)
        # Assume it's a model name
        MODELS+=("$1")
        shift
        ;;
    esac
done

# Validate arguments
if [[ -z "$MODE" ]] || [[ "$MODE" != "strict" && "$MODE" != "forgiving" ]]; then
    echo "Error: --mode must be 'strict' or 'forgiving'."
    usage
fi
if ! [[ "$NUM_RUNS" =~ ^[0-9]+$ ]] || [[ "$NUM_RUNS" -lt 1 ]]; then
    echo "Error: --num-runs must be a positive integer."
    usage
fi

# --- Default Model List ---
DEFAULT_MODELS=(
    "gemma3:4b" "falcon3:3b" "llama3.2:3b" "llama2:7b" "yi:6b" "phi3:mini"
    "smollm:360m" "gemma3:270m" "qwen:0.5b" "qwen2.5:0.5b" "qwen3:0.6b"
    "tinyllama:1.1b" "qwen2:1.5b" "stablelm2:1.6b" "deepseek-r1:1.5b"
    "qwen:1.8b" "llama3.2:1b" "phi:latest" "gemma:2b" "smollm2:1.7b"
    "falcon3:1b" "orca-mini:3b" "qwen:4b" "deepscaler:1.5b"
)
if [ ${#MODELS[@]} -eq 0 ]; then
    MODELS=("${DEFAULT_MODELS[@]}")
fi

# --- Path and Script Setup ---
abspath() {
    local target_path="$1"
    if [[ -d "$target_path" ]]; then
        pushd "$target_path" >/dev/null; pwd; popd >/dev/null
    else
        if [[ "$target_path" == /* ]]; then echo "$target_path"; else echo "$PWD/${target_path#./}"; fi
    fi
}

SCRIPT_DIR=$(dirname "$(realpath "$0")")
BASE_DIR=$(abspath "$(dirname "$SCRIPT_DIR")")
PYTHON_SCRIPT="$BASE_DIR/03_Scripts/run_cycle_test_syntactic.py"
RUN_TYPE="high_rep_${MODE}_n${NUM_RUNS}"
RESULTS_DIR="$BASE_DIR/04_RawData/run_${RUN_TYPE}_$(date +%Y%m%d_%H%M%S)"

# --- Configuration Echo ---
echo "Starting Benchmark Run..."
echo "===================================================="
echo "Mode:               $MODE"
echo "Models to test:     ${MODELS[@]}"
echo "Runs per test:      $NUM_RUNS"
echo "Results will be in: $RESULTS_DIR"
echo "===================================================="

mkdir -p "$RESULTS_DIR"

# --- Environment Checks ---
if [[ -n "$VENV_PATH" ]]; then
    source "$VENV_PATH/bin/activate"
    echo "Virtual environment activated."
fi
if [[ -z "$OLLAMA_API_URL" ]]; then
    echo "Error: OLLAMA_API_URL environment variable is not set. Exiting."
    exit 1
fi

# --- Main Execution Loop ---
for model in "${MODELS[@]}"; do
    for lang in "en" "ja"; do
        for spec_lang in "pseudocode" "s_expression" "minilang"; do
            for style in "fewshot" "hyper_guided"; do
                for (( i=1; i<=$NUM_RUNS; i++ )); do
                    run_id="${lang}_${spec_lang}_${style}_get_magic_number_run${i}"
                    output_dir="$RESULTS_DIR/${model//:/-}_${run_id}"

                    echo "--- STARTING: [$MODE] Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---" 
                    
                    # Build python command
                    CMD=(python3 "$PYTHON_SCRIPT" \
                        --model "$model" \
                        --test-case "get_magic_number" \
                        --spec-lang "$spec_lang" \
                        --prompt-style "$style" \
                        --lang "$lang" \
                        --output-dir "$output_dir" \
                        --api-url "$OLLAMA_API_URL" \
                        --max-cycles 10 \
                        --mode "$MODE")
                    
                    # Execute command
                    "${CMD[@]}"
                    
                    echo "--- FINISHED: [$MODE] Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---"
                    echo
                done
            done
        done
    done
done

# --- Result Aggregation ---
echo "Aggregating results into summary.csv..."
SUMMARY_FILE="$RESULTS_DIR/summary.csv"
echo "Model,Language,SpecLanguage,PromptStyle,Run,Status,CyclesCompleted" > "$SUMMARY_FILE"

find "$RESULTS_DIR" -name "result.json" | while read -r result_file; do
    dir_path=$(dirname "$result_file"); run_info=$(basename "$dir_path")
    model_part=$(echo "$run_info" | cut -d'_' -f1); lang=$(echo "$run_info" | cut -d'_' -f2)
    spec_lang=$(echo "$run_info" | cut -d'_' -f3); style=$(echo "$run_info" | cut -d'_' -f4)
    run_num=$(echo "$run_info" | sed -n 's/.*run\([0-9]*\)/\1/p'); model_name="${model_part//:/-}"
    status=$(python3 -c "import json,sys;f=open('$result_file');d=json.load(f);sys.stdout.write(d.get('status','ERROR').replace(',','_'))")
    cycles=$(python3 -c "import json,sys;f=open('$result_file');d=json.load(f);sys.stdout.write(str(d.get('cycles_completed',0)))")
    echo "$model_name,$lang,$spec_lang,$style,$run_num,\"$status\",$cycles" >> "$SUMMARY_FILE"
done

echo "Summary CSV created at $SUMMARY_FILE"
echo "Benchmark run completed. Results are in: $RESULTS_DIR"

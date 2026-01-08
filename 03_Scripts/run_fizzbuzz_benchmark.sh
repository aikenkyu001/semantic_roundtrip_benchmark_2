#!/bin/bash
# A dedicated script to run semantic round-trip benchmarks for the FizzBuzz test case.

# --- Usage ---
usage() {
    echo "Usage: $0 --mode <strict|forgiving>"
    echo ""
    echo "Arguments:"
    echo "  --mode <strict|forgiving>  : Set the test mode. 'strict' uses simple markdown parsing,"
    echo "                               'forgiving' uses AST-based syntactic parsing."
    exit 1
}

# --- Argument Parsing ---
MODE=""

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --mode)
            MODE="$2"
            shift; shift
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            ;;
    esac
done

# Validate arguments
if [[ -z "$MODE" ]] || [[ "$MODE" != "strict" && "$MODE" != "forgiving" ]]; then
    echo "Error: --mode must be 'strict' or 'forgiving'."
    usage
fi

# --- Experiment Specific Configuration ---
TEST_CASE="fizzbuzz"
NUM_RUNS=30 # 30 runs per combination for large-scale experiment

MODELS=(
    "gemma3:4b"
    "falcon3:3b"
    "llama3.2:3b"
)

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
RUN_TYPE="${TEST_CASE}_${MODE}" # Renamed to reflect the test case
RESULTS_DIR="$BASE_DIR/04_RawData/run_${RUN_TYPE}_$(date +%Y%m%d_%H%M%S)"

# --- Configuration Echo ---
echo "Starting FizzBuzz Benchmark Run..."
echo "===================================================="
echo "Test Case:          $TEST_CASE"
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
                    # Updated run_id to include test_case
                    run_id="${lang}_${spec_lang}_${style}_${TEST_CASE}_run${i}"
                    output_dir="$RESULTS_DIR/${model//:/-}_${run_id}"

                    echo "--- STARTING: [$MODE] Test=$TEST_CASE, Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---" 
                    
                    # Build python command
                    CMD=(python3 "$PYTHON_SCRIPT" \
                        --model "$model" \
                        --test-case "$TEST_CASE" \
                        --spec-lang "$spec_lang" \
                        --prompt-style "$style" \
                        --lang "$lang" \
                        --output-dir "$output_dir" \
                        --api-url "$OLLAMA_API_URL" \
                        --max-cycles 10 \
                        --mode "$MODE")
                    
                    # Execute command
                    "${CMD[@]}"
                    
                    echo "--- FINISHED: [$MODE] Test=$TEST_CASE, Model=$model, Lang=$lang, Spec=$spec_lang, Style=$style, Run=$i ---"
                    echo
                done
            done
        done
    done
done

# --- Result Aggregation ---
echo "Aggregating results into summary.csv..."
SUMMARY_FILE="$RESULTS_DIR/summary.csv"
echo "Model,Language,SpecLanguage,PromptStyle,TestCase,Run,Status,CyclesCompleted" > "$SUMMARY_FILE" # Added TestCase column

find "$RESULTS_DIR" -name "result.json" | while read -r result_file; do
    dir_path=$(dirname "$result_file"); run_info=$(basename "$dir_path")
    # Updated parsing of run_info to extract TestCase
    model_part=$(echo "$run_info" | cut -d'_' -f1); lang=$(echo "$run_info" | cut -d'_' -f2)
    spec_lang=$(echo "$run_info" | cut -d'_' -f3); style=$(echo "$run_info" | cut -d'_' -f4)
    test_case_from_name=$(echo "$run_info" | cut -d'_' -f5) # Extract test_case
    run_num=$(echo "$run_info" | sed -n 's/.*run\([0-9]*\)/\1/p'); model_name="${model_part//:/-}"
    
    status=$(python3 -c "import json,sys;f=open('$result_file');d=json.load(f);sys.stdout.write(d.get('status','ERROR').replace(',','_'))")
    cycles=$(python3 -c "import json,sys;f=open('$result_file');d=json.load(f);sys.stdout.write(str(d.get('cycles_completed',0)))")
    
    echo "$model_name,$lang,$spec_lang,$style,$test_case_from_name,$run_num,\"$status\",$cycles" >> "$SUMMARY_FILE"
done

echo "Summary CSV created at $SUMMARY_FILE"
echo "Benchmark run completed. Results are in: $RESULTS_DIR"

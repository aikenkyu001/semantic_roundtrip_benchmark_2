#!/bin/bash
#
# run_all_experiments.sh
#
# This script centralizes the execution of the key benchmark experiments for
# comparing model performance on a known task (fizzbuzz) versus a novel task
# of similar complexity (separate_vowels_and_consonants).
#

# --- Centralized Configuration ---
# Set the base URL for the Ollama API server.
OLLAMA_API_URL="http://192.168.3.213:11434"

# Set the default number of runs for each test combination.
# This can be overridden with the --num-runs flag.
NUM_RUNS=30

# --- Argument Parsing ---
CLI_MODELS=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --num-runs)
        NUM_RUNS="$2"
        shift; shift
        ;;
        *) # Assume it's a model name
        CLI_MODELS+=("$1")
        shift
        ;;
    esac
done

# --- Model Configuration ---
# Define the default models to be tested if none are provided via CLI.
MODELS_DEFAULT=(
    "falcon3:3b"
    "gemma3:4b"
    "llama3.2:3b"
)

# Use models from CLI if provided, otherwise use the default list.
if [ ${#CLI_MODELS[@]} -gt 0 ]; then
    MODELS_TO_TEST=("${CLI_MODELS[@]}")
else
    MODELS_TO_TEST=("${MODELS_DEFAULT[@]}")
fi

# Define the test cases for comparison.
TEST_CASES=(
    "fizzbuzz"
    "separate_vowels_and_consonants"
)

# --- Script Banner ---
echo "==========================================================" 
echo "Starting Comparative Benchmark Experiment"
echo "=========================================================="
echo "API Server:    $OLLAMA_API_URL"
echo "Models:        ${MODELS_TO_TEST[@]}"
echo "Test Cases:    ${TEST_CASES[@]}"
echo "Runs per test: $NUM_RUNS"
echo "=========================================================="
echo

# --- Execution Loop ---
BASE_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
BENCHMARK_SCRIPT="$BASE_SCRIPT_DIR/run_adaptive_benchmark.sh"

# Note: The 'run_cycle_test_syntactic.py' script, called by the benchmark,
# has been modified to bypass the strict spec-to-spec validation. This is the
# intended state for running these experiments to evaluate code generation.

for model in "${MODELS_TO_TEST[@]}"; do
    for test_case in "${TEST_CASES[@]}"; do
        
        # Clean model name for log file (replace : with -)
        model_logfile_name=$(echo "$model" | sed 's/:/-/g')
        log_file="07_Logs/${model_logfile_name}_${test_case}_n${NUM_RUNS}_log.txt"

        echo "---"
        echo "RUNNING: Model -> '$model', Test Case -> '$test_case'"
        echo "Output will be logged to: $log_file"
        echo "---"
        
        # Execute the benchmark in the background
        OLLAMA_API_URL="$OLLAMA_API_URL" "$BENCHMARK_SCRIPT" \
            --mode composite \
            --test-case "$test_case" \
            --num-runs "$NUM_RUNS" \
            "$model" > "$log_file" 2>&1 &

    done
done

echo
echo "All benchmark processes have been started in the background."
echo "You can monitor the log files for progress:"
for model in "${MODELS_TO_TEST[@]}"; do
    for test_case in "${TEST_CASES[@]}"; do
        model_logfile_name=$(echo "$model" | sed 's/:/-/g')
        echo "  - tail -f 07_Logs/${model_logfile_name}_${test_case}_n${NUM_RUNS}_log.txt"
    done
done
echo
echo "Waiting for all processes to complete... (This may take a long time)"

wait

echo
echo "=========================================================="
echo "All benchmark runs have completed."
echo "You can now run the analysis script to see the results:"
echo "  python3 05_Reports/analyze_with_ci.py"
echo "=========================================================="

#!/bin/bash

# Configuration
MODEL_NAME="llama3:8b"
OLLAMA_SERVER_IP="192.168.3.213"
OLLAMA_API_URL="http://${OLLAMA_SERVER_IP}:11434"
NUM_RUNS=30
SPEC_LANG="pseudocode"
PROMPT_STYLE="hyper_guided"
MAX_CYCLES=10

# --- Robust Path Setup ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
BASE_DIR=$(realpath "$SCRIPT_DIR/..")
PYTHON_SCRIPT="$SCRIPT_DIR/run_cycle_test_syntactic.py"
BASE_OUTPUT_DIR="$BASE_DIR/04_RawData/llm_test_${MODEL_NAME//:/-}_$(date +%Y%m%d_%H%M%S)"

echo "Starting LLM tests for model: ${MODEL_NAME}"
echo "Ollama API URL: ${OLLAMA_API_URL}"
echo "Results will be saved in: ${BASE_OUTPUT_DIR}"
mkdir -p "$BASE_OUTPUT_DIR"

TEST_CASES=("fizzbuzz" "separate_vowels_and_consonants")
LANGS=("en" "ja")

for test_case in "${TEST_CASES[@]}"; do
    for lang in "${LANGS[@]}"; do
        echo "Running ${test_case} in ${lang}..."
        for (( i=1; i<=$NUM_RUNS; i++ )); do
            RUN_ID="${lang}_${SPEC_LANG}_${PROMPT_STYLE}_${test_case}_run${i}"
            OUTPUT_DIR="${BASE_OUTPUT_DIR}/${MODEL_NAME//:/-}_${RUN_ID}"
            
            echo "  --> Run ${i}/${NUM_RUNS} for ${test_case} (${lang})"
            
            python3 "${PYTHON_SCRIPT}" \
                --model "${MODEL_NAME}" \
                --test-case "${test_case}" \
                --spec-lang "${SPEC_LANG}" \
                --prompt-style "${PROMPT_STYLE}" \
                --lang "${lang}" \
                --output-dir "${OUTPUT_DIR}" \
                --api-url "${OLLAMA_API_URL}" \
                --max-cycles "${MAX_CYCLES}"
            
            # Check if the python script exited successfully
            if [ $? -ne 0 ]; then
                echo "  !!! Python script failed for run ${i} of ${test_case} (${lang}). Check logs in ${OUTPUT_DIR} !!!"
            fi
        done
    done
done

echo "All specified tests for ${MODEL_NAME} completed."
echo "Results can be found in: ${BASE_OUTPUT_DIR}"

echo "----------------------------------------------------"
echo "To analyze results, you might want to aggregate them."
echo "You can manually inspect individual result.json files in subdirectories of:"
echo "${BASE_OUTPUT_DIR}"
echo "----------------------------------------------------"

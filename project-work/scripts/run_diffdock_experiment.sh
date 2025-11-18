#!/bin/bash
# Script to run DiffDock experiments
# Usage: ./run_diffdock_experiment.sh <experiment_name> <inference_steps> <samples_per_complex>

set -e  # Exit on error

# Configuration
EXPERIMENT_NAME=${1:-"diffdock_test"}
INFERENCE_STEPS=${2:-20}
SAMPLES_PER_COMPLEX=${3:-40}
BATCH_SIZE=${4:-10}

# Paths (adjust as needed)
PROJECT_ROOT="/home/user/DiffDock-Aalto-BioMedML"
DIFFDOCK_DIR="${PROJECT_ROOT}/DiffDock"
RESULTS_DIR="${PROJECT_ROOT}/project-work/results/${EXPERIMENT_NAME}"
LOG_DIR="${PROJECT_ROOT}/project-work/logs"

# Create directories
mkdir -p "${RESULTS_DIR}"
mkdir -p "${LOG_DIR}"

# Log file
LOG_FILE="${LOG_DIR}/${EXPERIMENT_NAME}_$(date +%Y%m%d_%H%M%S).log"

echo "========================================" | tee -a "${LOG_FILE}"
echo "DiffDock Experiment: ${EXPERIMENT_NAME}" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"
echo "Inference steps: ${INFERENCE_STEPS}" | tee -a "${LOG_FILE}"
echo "Samples per complex: ${SAMPLES_PER_COMPLEX}" | tee -a "${LOG_FILE}"
echo "Batch size: ${BATCH_SIZE}" | tee -a "${LOG_FILE}"
echo "Results directory: ${RESULTS_DIR}" | tee -a "${LOG_FILE}"
echo "Started at: $(date)" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"

# Change to DiffDock directory
cd "${DIFFDOCK_DIR}"

# Check if test set CSV exists
if [ ! -f "data/testset_csv.csv" ]; then
    echo "ERROR: data/testset_csv.csv not found!" | tee -a "${LOG_FILE}"
    echo "Please download the dataset first." | tee -a "${LOG_FILE}"
    exit 1
fi

# Check if ESM embeddings exist
if [ ! -d "data/esm2_output" ]; then
    echo "WARNING: ESM embeddings not found!" | tee -a "${LOG_FILE}"
    echo "You may need to generate embeddings first." | tee -a "${LOG_FILE}"
    echo "See experimental_plan.md for instructions." | tee -a "${LOG_FILE}"
fi

# Run inference
echo "Running DiffDock inference..." | tee -a "${LOG_FILE}"
python -m inference \
    --protein_ligand_csv data/testset_csv.csv \
    --out_dir "${RESULTS_DIR}" \
    --inference_steps ${INFERENCE_STEPS} \
    --samples_per_complex ${SAMPLES_PER_COMPLEX} \
    --batch_size ${BATCH_SIZE} \
    --actual_steps 18 \
    --no_final_step_noise \
    2>&1 | tee -a "${LOG_FILE}"

INFERENCE_EXIT_CODE=$?

if [ $INFERENCE_EXIT_CODE -ne 0 ]; then
    echo "ERROR: Inference failed with exit code ${INFERENCE_EXIT_CODE}" | tee -a "${LOG_FILE}"
    exit $INFERENCE_EXIT_CODE
fi

echo "Inference completed successfully!" | tee -a "${LOG_FILE}"

# Run evaluation
echo "Running evaluation..." | tee -a "${LOG_FILE}"
python evaluate_files.py \
    --results_path "${RESULTS_DIR}" \
    --file_to_exclude rank1.sdf \
    --num_predictions ${SAMPLES_PER_COMPLEX} \
    2>&1 | tee -a "${LOG_FILE}"

EVAL_EXIT_CODE=$?

if [ $EVAL_EXIT_CODE -ne 0 ]; then
    echo "WARNING: Evaluation completed with exit code ${EVAL_EXIT_CODE}" | tee -a "${LOG_FILE}"
fi

echo "========================================" | tee -a "${LOG_FILE}"
echo "Experiment completed at: $(date)" | tee -a "${LOG_FILE}"
echo "Results saved to: ${RESULTS_DIR}" | tee -a "${LOG_FILE}"
echo "Log file: ${LOG_FILE}" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"

# Copy log to results directory
cp "${LOG_FILE}" "${RESULTS_DIR}/experiment.log"

echo "Done! Check ${RESULTS_DIR} for results."

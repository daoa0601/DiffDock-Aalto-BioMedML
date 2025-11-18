#!/bin/bash
# Script to run DiffDock-L experiments
# Usage: ./run_diffdockL_experiment.sh <experiment_name> <inference_steps> <samples_per_complex>

set -e  # Exit on error

# Configuration
EXPERIMENT_NAME=${1:-"diffdockL_test"}
INFERENCE_STEPS=${2:-20}
SAMPLES_PER_COMPLEX=${3:-40}
BATCH_SIZE=${4:-10}

# Paths (adjust as needed)
PROJECT_ROOT="/home/user/DiffDock-Aalto-BioMedML"
DIFFDOCKL_DIR="${PROJECT_ROOT}/DiffDockL"
RESULTS_DIR="${PROJECT_ROOT}/project-work/results/${EXPERIMENT_NAME}"
LOG_DIR="${PROJECT_ROOT}/project-work/logs"

# Create directories
mkdir -p "${RESULTS_DIR}"
mkdir -p "${LOG_DIR}"

# Log file
LOG_FILE="${LOG_DIR}/${EXPERIMENT_NAME}_$(date +%Y%m%d_%H%M%S).log"

echo "========================================" | tee -a "${LOG_FILE}"
echo "DiffDock-L Experiment: ${EXPERIMENT_NAME}" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"
echo "Inference steps: ${INFERENCE_STEPS}" | tee -a "${LOG_FILE}"
echo "Samples per complex: ${SAMPLES_PER_COMPLEX}" | tee -a "${LOG_FILE}"
echo "Batch size: ${BATCH_SIZE}" | tee -a "${LOG_FILE}"
echo "Results directory: ${RESULTS_DIR}" | tee -a "${LOG_FILE}"
echo "Started at: $(date)" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"

# Change to DiffDock-L directory
cd "${DIFFDOCKL_DIR}"

# Check README for specific instructions
echo "NOTE: Check DiffDockL/README.md for specific parameters!" | tee -a "${LOG_FILE}"
echo "This script uses similar parameters to DiffDock but may need adjustment." | tee -a "${LOG_FILE}"

# Check if test set CSV exists (may need to use DiffDock's data)
TEST_CSV="${DIFFDOCKL_DIR}/data/testset_csv.csv"
if [ ! -f "${TEST_CSV}" ]; then
    echo "WARNING: ${TEST_CSV} not found, trying DiffDock's version..." | tee -a "${LOG_FILE}"
    TEST_CSV="${PROJECT_ROOT}/DiffDock/data/testset_csv.csv"
    if [ ! -f "${TEST_CSV}" ]; then
        echo "ERROR: Test set CSV not found!" | tee -a "${LOG_FILE}"
        exit 1
    fi
fi

# Run inference (adjust command based on DiffDockL's actual interface)
echo "Running DiffDock-L inference..." | tee -a "${LOG_FILE}"
echo "NOTE: You may need to adjust parameters based on DiffDockL README" | tee -a "${LOG_FILE}"

python -m inference \
    --protein_ligand_csv "${TEST_CSV}" \
    --out_dir "${RESULTS_DIR}" \
    --inference_steps ${INFERENCE_STEPS} \
    --samples_per_complex ${SAMPLES_PER_COMPLEX} \
    --batch_size ${BATCH_SIZE} \
    2>&1 | tee -a "${LOG_FILE}"

INFERENCE_EXIT_CODE=$?

if [ $INFERENCE_EXIT_CODE -ne 0 ]; then
    echo "ERROR: Inference failed with exit code ${INFERENCE_EXIT_CODE}" | tee -a "${LOG_FILE}"
    echo "Check if DiffDock-L uses different parameters/arguments" | tee -a "${LOG_FILE}"
    exit $INFERENCE_EXIT_CODE
fi

echo "Inference completed successfully!" | tee -a "${LOG_FILE}"

# Run evaluation (if DiffDockL has evaluate_files.py)
if [ -f "evaluate_files.py" ]; then
    echo "Running evaluation..." | tee -a "${LOG_FILE}"
    python evaluate_files.py \
        --results_path "${RESULTS_DIR}" \
        --file_to_exclude rank1.sdf \
        --num_predictions ${SAMPLES_PER_COMPLEX} \
        2>&1 | tee -a "${LOG_FILE}"
else
    echo "WARNING: evaluate_files.py not found in DiffDockL" | tee -a "${LOG_FILE}"
    echo "You may need to evaluate using DiffDock's evaluation script" | tee -a "${LOG_FILE}"
fi

echo "========================================" | tee -a "${LOG_FILE}"
echo "Experiment completed at: $(date)" | tee -a "${LOG_FILE}"
echo "Results saved to: ${RESULTS_DIR}" | tee -a "${LOG_FILE}"
echo "Log file: ${LOG_FILE}" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"

# Copy log to results directory
cp "${LOG_FILE}" "${RESULTS_DIR}/experiment.log"

echo "Done! Check ${RESULTS_DIR} for results."

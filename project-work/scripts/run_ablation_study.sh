#!/bin/bash
# Script to run ablation study on inference steps
# Tests different numbers of inference steps to find optimal trade-off

set -e

PROJECT_ROOT="/home/user/DiffDock-Aalto-BioMedML"
SCRIPT_DIR="${PROJECT_ROOT}/project-work/scripts"
LOG_DIR="${PROJECT_ROOT}/project-work/logs"

mkdir -p "${LOG_DIR}"

LOG_FILE="${LOG_DIR}/ablation_study_$(date +%Y%m%d_%H%M%S).log"

echo "========================================" | tee -a "${LOG_FILE}"
echo "Ablation Study: Inference Steps" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"
echo "Started at: $(date)" | tee -a "${LOG_FILE}"
echo "" | tee -a "${LOG_FILE}"

# Define inference steps to test
STEPS=(5 10 20 40)
SAMPLES_PER_COMPLEX=40
BATCH_SIZE=10

echo "Testing inference steps: ${STEPS[@]}" | tee -a "${LOG_FILE}"
echo "Samples per complex: ${SAMPLES_PER_COMPLEX}" | tee -a "${LOG_FILE}"
echo "" | tee -a "${LOG_FILE}"

# Run experiments for each setting
for STEP in "${STEPS[@]}"; do
    echo "----------------------------------------" | tee -a "${LOG_FILE}"
    echo "Running experiment with ${STEP} inference steps..." | tee -a "${LOG_FILE}"
    echo "----------------------------------------" | tee -a "${LOG_FILE}"

    EXPERIMENT_NAME="ablation_steps${STEP}"

    # Record start time
    START_TIME=$(date +%s)

    # Run experiment
    bash "${SCRIPT_DIR}/run_diffdock_experiment.sh" \
        "${EXPERIMENT_NAME}" \
        "${STEP}" \
        "${SAMPLES_PER_COMPLEX}" \
        "${BATCH_SIZE}" \
        2>&1 | tee -a "${LOG_FILE}"

    # Record end time
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))

    echo "Experiment with ${STEP} steps completed in ${DURATION} seconds" | tee -a "${LOG_FILE}"
    echo "" | tee -a "${LOG_FILE}"
done

echo "========================================" | tee -a "${LOG_FILE}"
echo "Ablation Study Completed!" | tee -a "${LOG_FILE}"
echo "Completed at: $(date)" | tee -a "${LOG_FILE}"
echo "========================================" | tee -a "${LOG_FILE}"
echo "" | tee -a "${LOG_FILE}"
echo "Results directories:" | tee -a "${LOG_FILE}"
for STEP in "${STEPS[@]}"; do
    echo "  - project-work/results/ablation_steps${STEP}/" | tee -a "${LOG_FILE}"
done
echo "" | tee -a "${LOG_FILE}"
echo "Next step: Run analyze_ablation.py to compare results" | tee -a "${LOG_FILE}"

echo "Done! Log saved to ${LOG_FILE}"

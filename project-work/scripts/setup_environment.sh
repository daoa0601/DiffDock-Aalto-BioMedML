#!/bin/bash
# Script to set up the environment for running experiments
# This checks dependencies and helps with initial setup

set -e

PROJECT_ROOT="/home/user/DiffDock-Aalto-BioMedML"

echo "========================================="
echo "DiffDock Experiment Environment Setup"
echo "========================================="
echo ""

# Check if conda is available
if ! command -v conda &> /dev/null; then
    echo "ERROR: conda not found! Please install Anaconda or Miniconda."
    exit 1
else
    echo "✓ conda found: $(conda --version)"
fi

# Check if DiffDock conda environment exists
echo ""
echo "Checking for DiffDock conda environment..."
if conda env list | grep -q "diffdock"; then
    echo "✓ diffdock environment exists"
else
    echo "✗ diffdock environment not found"
    echo ""
    echo "To create the environment:"
    echo "  cd ${PROJECT_ROOT}/DiffDock"
    echo "  conda env create -f environment.yml"
    echo "  conda activate diffdock"
    echo "  # Install additional dependencies as needed"
fi

# Check Python packages (if environment is active)
echo ""
echo "Checking Python packages (if diffdock env is active)..."
if [[ "$CONDA_DEFAULT_ENV" == "diffdock" ]]; then
    echo "Environment 'diffdock' is active"

    # Check for key packages
    python -c "import torch; print('✓ PyTorch:', torch.__version__)" 2>/dev/null || echo "✗ PyTorch not found"
    python -c "import torch_geometric; print('✓ PyTorch Geometric:', torch_geometric.__version__)" 2>/dev/null || echo "✗ PyTorch Geometric not found"
    python -c "import rdkit; print('✓ RDKit found')" 2>/dev/null || echo "✗ RDKit not found"
    python -c "import esm; print('✓ ESM found')" 2>/dev/null || echo "✗ ESM not found"
else
    echo "diffdock environment not active. Activate it with:"
    echo "  conda activate diffdock"
fi

# Check GPU availability
echo ""
echo "Checking GPU availability..."
if command -v nvidia-smi &> /dev/null; then
    echo "✓ nvidia-smi found"
    nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
else
    echo "✗ nvidia-smi not found (GPU not available or drivers not installed)"
    echo "  Note: DiffDock can run on CPU but will be slower"
fi

# Check data directory
echo ""
echo "Checking data availability..."
if [ -d "${PROJECT_ROOT}/DiffDock/data/PDBBind_processed" ]; then
    echo "✓ PDBBind processed data found"
else
    echo "✗ PDBBind processed data not found"
    echo ""
    echo "To download the data:"
    echo "  1. Visit: https://zenodo.org/record/6408497"
    echo "  2. Download the PDBBind dataset"
    echo "  3. Extract to: ${PROJECT_ROOT}/DiffDock/data/PDBBind_processed"
fi

if [ -d "${PROJECT_ROOT}/DiffDock/data/esm2_output" ]; then
    echo "✓ ESM2 embeddings found"
else
    echo "✗ ESM2 embeddings not found"
    echo ""
    echo "To generate ESM2 embeddings, see experimental_plan.md"
fi

# Check model weights
echo ""
echo "Checking model weights..."
if [ -d "${PROJECT_ROOT}/DiffDock/workdir" ]; then
    echo "✓ Model weights directory exists"
else
    echo "✗ Model weights not found"
    echo ""
    echo "Model weights should be downloaded automatically on first run"
    echo "Or manually download from the DiffDock repository"
fi

# Create necessary directories
echo ""
echo "Creating project directories..."
mkdir -p "${PROJECT_ROOT}/project-work/results"
mkdir -p "${PROJECT_ROOT}/project-work/logs"
mkdir -p "${PROJECT_ROOT}/project-work/figures"
mkdir -p "${PROJECT_ROOT}/project-work/tables"
echo "✓ Directories created"

# Check for AutoDock Vina (for baseline)
echo ""
echo "Checking for AutoDock Vina (baseline)..."
if command -v vina &> /dev/null; then
    echo "✓ Vina found: $(vina --version 2>&1 | head -n1)"
else
    echo "✗ Vina not found"
    echo ""
    echo "To install Vina:"
    echo "  conda install -c conda-forge vina"
fi

# Make scripts executable
echo ""
echo "Making scripts executable..."
chmod +x "${PROJECT_ROOT}/project-work/scripts"/*.sh
echo "✓ Scripts are executable"

echo ""
echo "========================================="
echo "Setup check complete!"
echo "========================================="
echo ""
echo "Quick start:"
echo "  1. conda activate diffdock"
echo "  2. cd ${PROJECT_ROOT}/project-work/scripts"
echo "  3. ./run_diffdock_experiment.sh diffdock_test 20 40"
echo ""
echo "See experimental_plan.md for detailed instructions."

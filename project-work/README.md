# Project Work Directory

This directory contains all materials for the DiffDock evaluation project for the "Machine Learning for Biomedicine" course.

## Directory Structure

```
project-work/
├── README.md                      # This file
├── experimental_plan.md           # Detailed plan for all experiments
├── experiment_tracking.md         # Template for tracking progress
├── results_template.md            # Template for documenting results
├── scripts/                       # Helper scripts for running experiments
│   ├── setup_environment.sh       # Check and setup environment
│   ├── run_diffdock_experiment.sh # Run DiffDock experiments
│   ├── run_diffdockL_experiment.sh# Run DiffDock-L experiments
│   ├── run_ablation_study.sh      # Run ablation study
│   ├── analyze_results.py         # Analyze and compare results
│   └── analyze_ablation.py        # Analyze ablation study
├── results/                       # Experiment results (created during runs)
├── logs/                          # Experiment logs (created during runs)
├── figures/                       # Generated figures for report
└── tables/                        # Generated tables for report
```

## Quick Start Guide

### 1. Environment Setup

First, check your environment and dependencies:

```bash
cd project-work/scripts
./setup_environment.sh
```

This will verify:
- Conda installation
- Python packages
- GPU availability
- Data availability
- Required software (Vina for baselines)

### 2. Activate Environment

```bash
conda activate diffdock
```

### 3. Run Your First Experiment

**MUST DO: Reproduce Paper Results**

```bash
cd project-work/scripts
./run_diffdock_experiment.sh diffdock_testset 20 40
```

This runs DiffDock with:
- 20 inference steps
- 40 samples per complex
- Results saved to `../results/diffdock_testset/`

### 4. Analyze Results

```bash
python analyze_results.py \
    --results_dir ../results \
    --experiments diffdock_testset \
    --output ../tables/results_summary.csv
```

## Experiment Priorities

### MUST DO ✓
1. **Reproduce Paper Results**: `./run_diffdock_experiment.sh diffdock_testset 20 40`
2. **Vina Baseline**: See `experimental_plan.md` for Vina setup

### SHOULD DO ✓✓
3. **DiffDock vs DiffDock-L**: `./run_diffdockL_experiment.sh diffdockL_testset 20 40`

### NICE TO HAVE ✓✓✓
4. **Ablation Study**: `./run_ablation_study.sh`

See `experimental_plan.md` for detailed instructions on each experiment.

## Using the Scripts

### Running DiffDock Experiments

**Basic usage:**
```bash
./run_diffdock_experiment.sh <experiment_name> <inference_steps> <samples_per_complex>
```

**Examples:**
```bash
# Reproduce paper results
./run_diffdock_experiment.sh diffdock_paper 20 40

# Quick test with fewer samples
./run_diffdock_experiment.sh diffdock_quick_test 10 10

# High accuracy mode
./run_diffdock_experiment.sh diffdock_high_acc 40 100
```

### Running DiffDock-L Experiments

**Basic usage:**
```bash
./run_diffdockL_experiment.sh <experiment_name> <inference_steps> <samples_per_complex>
```

**Example:**
```bash
./run_diffdockL_experiment.sh diffdockL_testset 20 40
```

### Running Ablation Study

Tests multiple inference step settings automatically:

```bash
./run_ablation_study.sh
```

This will run experiments with 5, 10, 20, and 40 inference steps.

### Analyzing Results

**Compare multiple experiments:**
```bash
python analyze_results.py \
    --results_dir ../results \
    --experiments exp1 exp2 exp3 \
    --output ../tables/comparison.csv
```

**Analyze ablation study:**
```bash
python analyze_ablation.py \
    --results_dir ../results \
    --steps 5 10 20 40 \
    --output_dir ../figures
```

## Tracking Your Progress

Use `experiment_tracking.md` to:
- Track experiment status
- Document parameters
- Record results
- Note observations
- Track blockers

Update it as you complete experiments!

## Documenting Results

Use `results_template.md` to:
- Document all experimental results
- Create tables for your report
- Organize figures
- Write analysis sections
- Prepare for final report

## Common Workflows

### Workflow 1: Complete MUST DO Experiments

```bash
# 1. Setup
./setup_environment.sh
conda activate diffdock

# 2. Run DiffDock
./run_diffdock_experiment.sh diffdock_testset 20 40

# 3. Setup and run Vina (see experimental_plan.md)
# ... Vina setup steps ...

# 4. Compare results
python analyze_results.py \
    --results_dir ../results \
    --experiments diffdock_testset vina_testset \
    --output ../tables/comparison_diffdock_vs_vina.csv
```

### Workflow 2: DiffDock vs DiffDock-L

```bash
# 1. Run both versions
./run_diffdock_experiment.sh diffdock_comparison 20 40
./run_diffdockL_experiment.sh diffdockL_comparison 20 40

# 2. Compare
python analyze_results.py \
    --results_dir ../results \
    --experiments diffdock_comparison diffdockL_comparison \
    --output ../tables/comparison_versions.csv
```

### Workflow 3: Ablation Study

```bash
# 1. Run ablation study
./run_ablation_study.sh

# 2. Analyze and create plots
python analyze_ablation.py \
    --results_dir ../results \
    --steps 5 10 20 40 \
    --output_dir ../figures

# Results will be in:
# - ../figures/ablation_inference_steps.png
# - ../figures/ablation_inference_steps.csv
```

## File Locations After Running

After running experiments, you'll find:

**Results**: `project-work/results/<experiment_name>/`
- Generated poses (SDF files)
- Evaluation metrics (CSV)
- Experiment log

**Logs**: `project-work/logs/`
- Detailed execution logs with timestamps

**Figures**: `project-work/figures/`
- Generated plots (from analysis scripts)

**Tables**: `project-work/tables/`
- CSV files with comparison data

## Tips and Best Practices

1. **Start Small**: Test on 1-2 complexes before running full dataset
2. **Document Everything**: Update `experiment_tracking.md` regularly
3. **Save Intermediate Results**: Don't re-run expensive computations
4. **Check Logs**: If something fails, check the log files
5. **Version Control**: Commit scripts and configurations (but not large result files)
6. **Backup Results**: Copy important results before re-running experiments

## Troubleshooting

### Environment Issues
- Run `./setup_environment.sh` to diagnose
- Check conda environment: `conda activate diffdock`
- Verify Python packages: `python -c "import torch; print(torch.__version__)"`

### Data Issues
- Missing PDBBind data: Download from Zenodo (see `experimental_plan.md`)
- Missing ESM embeddings: Generate using instructions in `experimental_plan.md`

### GPU Issues
- Check availability: `nvidia-smi`
- DiffDock will run on CPU if GPU not available (slower)

### Script Errors
- Check script has execute permissions: `chmod +x script.sh`
- Verify paths in script match your setup
- Check log files for detailed error messages

## Getting Help

1. Check `experimental_plan.md` for detailed instructions
2. Review `experiment_tracking.md` for common issues
3. Look at DiffDock README: `../DiffDock/README.md`
4. Check log files in `logs/` directory

## Timeline Suggestion

**Week 1-2**: Setup + MUST DO experiments
- Environment setup
- Reproduce paper results
- Vina baseline

**Week 3**: SHOULD DO experiments
- DiffDock vs DiffDock-L comparison
- Initial analysis

**Week 4**: NICE TO HAVE + Analysis
- Ablation study
- Failure analysis
- Create figures and tables

**Week 5-6**: Report Writing
- Organize results
- Write report
- Create final figures

## For the Final Report

Use these files to populate your report:

1. **Methods section**: Copy from `experimental_plan.md`
2. **Results section**: Use `results_template.md`
3. **Figures**: From `figures/` directory
4. **Tables**: From `tables/` directory
5. **Discussion**: Insights from `experiment_tracking.md`

## Contact

For questions about the project, refer to:
- Course materials: `project_biomed.md`
- DiffDock paper: See `other_methods.md` for references
- Team members: (add your team contact info here)

---

Good luck with your experiments!

# DiffDock Experiments - Quick Reference Card

## One-Page Quick Start

### Setup (Do Once)
```bash
cd /home/user/DiffDock-Aalto-BioMedML/project-work/scripts
./setup_environment.sh
conda activate diffdock
```

### Essential Commands

#### 1. MUST DO: Reproduce Paper (Top Priority)
```bash
./run_diffdock_experiment.sh diffdock_testset 20 40
# Results: ../results/diffdock_testset/
```

#### 2. MUST DO: Run Vina Baseline
```bash
# Install Vina first
conda install -c conda-forge vina

# Then prepare and run (see experimental_plan.md for details)
# Vina requires manual setup per complex
```

#### 3. SHOULD DO: Compare DiffDock Versions
```bash
./run_diffdockL_experiment.sh diffdockL_testset 20 40
# Results: ../results/diffdockL_testset/
```

#### 4. NICE TO HAVE: Ablation Study
```bash
./run_ablation_study.sh
# Tests: 5, 10, 20, 40 inference steps
```

### Analyze Results
```bash
# Compare experiments
python analyze_results.py \
    --experiments diffdock_testset diffdockL_testset \
    --output ../tables/comparison.csv

# Analyze ablation
python analyze_ablation.py \
    --steps 5 10 20 40 \
    --output_dir ../figures
```

## File Cheat Sheet

| File | Purpose |
|------|---------|
| `experimental_plan.md` | Detailed experiment instructions |
| `experiment_tracking.md` | Track your progress |
| `results_template.md` | Document results for report |
| `README.md` | Full documentation |
| `QUICKSTART.md` | This file |

## Script Parameters

### run_diffdock_experiment.sh
```bash
./run_diffdock_experiment.sh <name> <steps> <samples>
# Example: ./run_diffdock_experiment.sh test 20 40
```

**Common Configurations:**
- **Paper reproduction**: `20` steps, `40` samples
- **Quick test**: `10` steps, `10` samples
- **High accuracy**: `40` steps, `100` samples

## Expected Results

| Metric | Expected Value |
|--------|---------------|
| Top-1 Success (2Å) | ~38% |
| Top-5 Success (2Å) | ~55-60% |
| Runtime/complex | ~30-60s (GPU) |

## Timeline

| Week | Tasks |
|------|-------|
| 1-2 | Setup, reproduce results, Vina baseline |
| 3 | DiffDock-L comparison |
| 4 | Ablation study, analysis |
| 5-6 | Report writing |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "conda not found" | Install Anaconda/Miniconda |
| "GPU not available" | Will run on CPU (slower) |
| "Data not found" | Download from Zenodo (see plan) |
| "Script permission denied" | Run `chmod +x script.sh` |

## Where Are My Results?

```
project-work/
├── results/          ← Experiment outputs here
│   ├── diffdock_testset/
│   ├── diffdockL_testset/
│   └── ablation_steps*/
├── logs/             ← Detailed logs here
├── figures/          ← Generated plots here
└── tables/           ← CSV results here
```

## Priority Checklist

### Minimum for Good Report
- [ ] Reproduce paper results
- [ ] Run Vina baseline
- [ ] Create comparison table
- [ ] Document methodology

### For Excellent Report
- [ ] All of above
- [ ] DiffDock vs DiffDock-L analysis ⭐
- [ ] Ablation study
- [ ] Failure analysis
- [ ] Professional figures

## Key Metrics to Report

1. **Success Rate** (< 2Å RMSD): Top-1, Top-5, Top-10
2. **RMSD**: Mean and median
3. **Runtime**: Per complex and total
4. **Comparison**: DiffDock vs baseline(s)

## Analysis Scripts

```bash
# Basic comparison
python analyze_results.py \
    --experiments exp1 exp2 \
    --output ../tables/comparison.csv

# Ablation analysis (with plots)
python analyze_ablation.py \
    --steps 5 10 20 40 \
    --output_dir ../figures
```

## Report Sections from Experiments

| Experiment | Report Section |
|------------|----------------|
| Reproduce paper | Validation of methodology |
| Vina baseline | Comparative evaluation |
| DiffDock-L | Evolution/improvements analysis |
| Ablation | Parameter sensitivity |

## Pro Tips

1. ✓ Test on 1-2 complexes first
2. ✓ Save logs - they're useful for debugging
3. ✓ Update tracking.md as you go
4. ✓ Commit code, not large result files
5. ✓ Start report writing early

## Need More Detail?

- **Setup instructions**: `experimental_plan.md`
- **Full documentation**: `README.md`
- **Track progress**: `experiment_tracking.md`
- **Document results**: `results_template.md`

---

**Remember**: Quality > Quantity.

A well-documented reproduction + one good baseline comparison is better than many rushed experiments!

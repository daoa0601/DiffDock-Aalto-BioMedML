# Experiment Tracking Log

## Purpose
Track all experiments, parameters, results, and observations for reproducibility and report writing.

---

## Experiment Status Overview

| Experiment ID | Name | Priority | Status | Date Started | Date Completed |
|--------------|------|----------|--------|--------------|----------------|
| EXP-001 | Reproduce Paper Results | MUST DO | Not Started | | |
| EXP-002 | Vina Baseline | MUST DO | Not Started | | |
| EXP-003 | DiffDock vs DiffDock-L | SHOULD DO | Not Started | | |
| EXP-004 | Ablation: Inference Steps | NICE TO HAVE | Not Started | | |
| EXP-005 | Failure Analysis | OPTIONAL | Not Started | | |
| EXP-006 | Confidence Evaluation | OPTIONAL | Not Started | | |

**Status codes**: Not Started | In Progress | Completed | Failed | Blocked

---

## EXP-001: Reproduce DiffDock Paper Results

**Priority**: MUST DO
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Validate DiffDock implementation by reproducing results from the original paper.

### Setup
- **Model**: DiffDock (original)
- **Dataset**: PDBBind test set (time-based split)
- **Test Set Size**: _____ complexes
- **Hardware**: GPU: _____ | RAM: _____ | CPU: _____

### Parameters
```yaml
inference_steps: 20
samples_per_complex: 40
batch_size: 10
actual_steps: 18
no_final_step_noise: true
```

### Results
| Metric | Our Result | Paper Result | Difference |
|--------|-----------|--------------|------------|
| Top-1 Success Rate (2Å) | ___% | 38.0% | ___% |
| Top-5 Success Rate (2Å) | ___% | ~55-60% | ___% |
| Top-10 Success Rate (2Å) | ___% | ~65-70% | ___% |
| Average Runtime (per complex) | ___s | ___s | ___s |
| Total Runtime | ___h | - | - |

### Files Generated
- Results directory: `results/diffdock_testset/`
- Evaluation output: `results/diffdock_testset/evaluation.csv`
- Log file: `results/diffdock_testset/run.log`

### Observations
_Notes on any issues, unexpected behavior, or insights:_
-
-
-

### Status Notes
_Track progress and blockers:_
- [ ] Environment set up
- [ ] Data downloaded
- [ ] ESM embeddings generated
- [ ] Inference completed
- [ ] Results evaluated
- [ ] Results documented

---

## EXP-002: AutoDock Vina Baseline

**Priority**: MUST DO
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Compare DiffDock against traditional docking method (AutoDock Vina).

### Setup
- **Baseline Method**: AutoDock Vina
- **Version**: _____
- **Dataset**: Same as EXP-001 (or subset: _____ complexes)
- **Hardware**: CPU cores: _____

### Parameters
```yaml
exhaustiveness: 8
num_modes: 9  # Vina outputs up to 9 poses
energy_range: 3
```

### Results
| Metric | Vina | DiffDock | Winner |
|--------|------|----------|--------|
| Top-1 Success Rate (2Å) | ___% | ___% | ___ |
| Top-5 Success Rate (2Å) | ___% | ___% | ___ |
| Top-9 Success Rate (2Å) | ___% | ___% | ___ |
| Avg RMSD (best pose) | ___Å | ___Å | ___ |
| Avg Runtime (per complex) | ___s | ___s | ___ |
| Total Runtime | ___h | ___h | ___ |

### Files Generated
- Results directory: `results/vina_testset/`
- Evaluation output: `results/vina_testset/evaluation.csv`
- Comparison table: `results/comparison_vina_vs_diffdock.csv`

### Observations
_Compare failure modes, strengths, weaknesses:_
-
-
-

### Status Notes
- [ ] Vina installed
- [ ] Input files prepared (PDBQT conversion)
- [ ] Docking completed
- [ ] RMSD calculation done
- [ ] Comparison analysis complete

---

## EXP-003: DiffDock vs DiffDock-L Comparison

**Priority**: SHOULD DO
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Compare original DiffDock with DiffDock-L (2024 version) to evaluate improvements.

### Setup
- **Models**: DiffDock (original) vs DiffDock-L
- **Dataset**: Same test set or representative subset
- **Test Set Size**: _____ complexes

### Parameters (DiffDock-L)
```yaml
# Check DiffDockL README for correct parameters
inference_steps: _____
samples_per_complex: _____
batch_size: _____
# Note any parameter differences
```

### Results
| Metric | DiffDock | DiffDock-L | Improvement |
|--------|----------|------------|-------------|
| Top-1 Success Rate (2Å) | ___% | ___% | ___% |
| Top-5 Success Rate (2Å) | ___% | ___% | ___% |
| Top-10 Success Rate (2Å) | ___% | ___% | ___% |
| Avg RMSD (best pose) | ___Å | ___Å | ___Å |
| Avg Runtime (per complex) | ___s | ___s | ___s |
| Model Size | ___MB | ___MB | ___MB |

### Key Differences
_What changed in DiffDock-L?_
- Architecture changes:
- Training improvements:
- New features:

### Files Generated
- DiffDock-L results: `results/diffdockL_testset/`
- Comparison: `results/diffdock_vs_diffdockL_comparison.csv`

### Observations
_Is DiffDock-L worth the update?_
-
-
-

### Status Notes
- [ ] DiffDock-L environment set up
- [ ] Model weights downloaded
- [ ] Inference completed
- [ ] Comparison analysis done
- [ ] Recommendation formed

---

## EXP-004: Ablation Study - Inference Steps

**Priority**: NICE TO HAVE
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Understand trade-off between inference steps, accuracy, and speed.

### Setup
- **Model**: DiffDock
- **Dataset**: Subset of test set (_____ complexes)
- **Variables**: Number of inference steps

### Experiments
| Run | Inference Steps | samples_per_complex | Other params |
|-----|----------------|---------------------|--------------|
| A | 5 | 40 | same as paper |
| B | 10 | 40 | same as paper |
| C | 20 | 40 | same as paper |
| D | 40 | 40 | same as paper |

### Results
| Inference Steps | Top-1 Success | Top-5 Success | Avg Runtime | Speedup |
|----------------|---------------|---------------|-------------|---------|
| 5 | ___% | ___% | ___s | ___x |
| 10 | ___% | ___% | ___s | ___x |
| 20 (paper) | ___% | ___% | ___s | 1.0x |
| 40 | ___% | ___% | ___s | ___x |

### Analysis
_Key insights on accuracy vs speed trade-off:_
- Diminishing returns after ___ steps?
- Optimal setting for practical use:
- When to use fewer steps:
- When to use more steps:

### Files Generated
- Results: `results/ablation_steps{5,10,20,40}/`
- Analysis: `results/ablation_analysis.csv`
- Plots: `figures/accuracy_vs_steps.png`, `figures/runtime_vs_steps.png`

### Status Notes
- [ ] Subset prepared
- [ ] All runs completed
- [ ] Results analyzed
- [ ] Plots generated

---

## EXP-005: Failure Analysis

**Priority**: OPTIONAL
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Understand when and why DiffDock fails; compare with baseline failures.

### Approach
1. Identify worst cases (highest RMSD) from EXP-001
2. Analyze protein/ligand characteristics
3. Compare with Vina failures
4. Form hypotheses

### Failure Cases Identified
| Complex ID | RMSD (Å) | Protein Family | Ligand MW | Rot Bonds | Notes |
|-----------|----------|----------------|-----------|-----------|-------|
| | | | | | |
| | | | | | |
| | | | | | |

### Common Characteristics
_What makes complexes "hard"?_
- Protein properties:
  -
- Ligand properties:
  -
- Binding site properties:
  -

### DiffDock vs Vina Failures
- Failures unique to DiffDock:
- Failures unique to Vina:
- Common failures:

### Insights
_What did we learn?_
-
-

### Files Generated
- Failure cases list: `results/failure_analysis/failure_cases.csv`
- Analysis: `results/failure_analysis/analysis.md`

---

## EXP-006: Confidence Model Evaluation

**Priority**: OPTIONAL
**Status**: Not Started
**Started**: _____
**Completed**: _____

### Objective
Evaluate how well DiffDock's confidence scores correlate with actual accuracy.

### Analysis
1. Correlation between confidence and RMSD
2. ROC curve for pose ranking
3. Calibration of confidence scores

### Results
| Metric | Value |
|--------|-------|
| Pearson correlation (confidence vs RMSD) | _____ |
| Spearman correlation | _____ |
| AUC (success at 2Å) | _____ |
| Top confidence = Top accuracy (%) | ___% |

### Insights
- Is confidence reliable for ranking poses?
- Can confidence identify failures?
- How to use confidence in practice?

### Files Generated
- Analysis: `results/confidence_analysis/`
- Plots: `figures/confidence_vs_rmsd.png`, `figures/confidence_roc.png`

---

## General Experiment Notes

### Common Issues Encountered
_Track common problems and solutions:_
1.
2.
3.

### Computational Resources Used
| Resource | Amount |
|----------|--------|
| Total GPU hours | _____ |
| Total CPU hours | _____ |
| Disk space used | _____ GB |
| Peak RAM usage | _____ GB |

### Data Management
- Raw results location: `project-work/results/`
- Processed data: `project-work/results/processed/`
- Figures: `project-work/figures/`
- Tables for paper: `project-work/tables/`

### Key Decisions Made
_Document important choices:_
1.
2.
3.

---

## Report Writing Checklist

Using experiment results:
- [ ] Results section drafted
- [ ] Figures created (accuracy comparison, runtime, etc.)
- [ ] Tables created (method comparison, ablation results)
- [ ] Discussion points identified
- [ ] Limitations documented
- [ ] Future work ideas noted

---

## Contact & Collaboration Notes

Team members responsible:
- Experiment setup:
- Running experiments:
- Analysis:
- Report writing:

Meeting notes:
-
-

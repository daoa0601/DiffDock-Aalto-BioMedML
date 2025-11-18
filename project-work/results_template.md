# DiffDock Experiment Results Template

## Purpose
This template provides a structured format for documenting and presenting experimental results for your report.

---

## 1. Reproduction of Original Paper Results

### Experimental Setup
- **Model**: DiffDock (original)
- **Dataset**: PDBBind test set (time-based split)
- **Test Set Size**: _____ complexes
- **Parameters**:
  - Inference steps: 20
  - Samples per complex: 40
  - Batch size: 10

### Results Table

| Metric | Our Results | Paper Results | Difference | Status |
|--------|------------|---------------|------------|--------|
| Top-1 Success Rate (< 2Å) | ___% | 38.0% | ___% | ✓/✗ |
| Top-5 Success Rate (< 2Å) | ___% | ~55-60% | ___% | ✓/✗ |
| Top-10 Success Rate (< 2Å) | ___% | ~65-70% | ___% | ✓/✗ |
| Mean RMSD (best pose) | ___Å | ___Å | ___Å | - |
| Median RMSD (best pose) | ___Å | ___Å | ___Å | - |

### Validation
- [ ] Results within acceptable margin (±5%) of paper results
- [ ] Same test set used
- [ ] Same evaluation protocol
- [ ] No data leakage

### Notes
_Any deviations from paper, issues encountered, or observations:_
-
-

---

## 2. Baseline Comparison

### 2.1 DiffDock vs AutoDock Vina

#### Experimental Setup
- **Baseline**: AutoDock Vina
- **Dataset**: Same as above (or subset if limited)
- **Test Set Size**: _____ complexes
- **Vina Parameters**:
  - Exhaustiveness: 8
  - Num modes: 9

#### Performance Comparison

| Metric | DiffDock | AutoDock Vina | Improvement | p-value |
|--------|----------|---------------|-------------|---------|
| Top-1 Success Rate (< 2Å) | ___% | ___% | ___% | ___ |
| Top-5 Success Rate (< 2Å) | ___% | ___% | ___% | ___ |
| Top-9/10 Success Rate | ___% | ___% | ___% | ___ |
| Mean RMSD (Å) | ___ | ___ | ___ | ___ |
| Median RMSD (Å) | ___ | ___ | ___ | ___ |
| Std Dev RMSD (Å) | ___ | ___ | ___ | - |

#### Runtime Comparison

| Metric | DiffDock | AutoDock Vina | Speedup |
|--------|----------|---------------|---------|
| Mean time per complex | ___s | ___s | ___x |
| Total runtime | ___h | ___h | ___x |
| Throughput (complexes/hour) | ___ | ___ | ___x |

#### Analysis
**DiffDock Advantages:**
-
-

**Vina Advantages:**
-
-

**When to use each method:**
- DiffDock:
- Vina:

---

## 3. DiffDock vs DiffDock-L Comparison

### Experimental Setup
- **Models**: DiffDock (2023) vs DiffDock-L (2024)
- **Dataset**: Same test set or representative subset
- **Test Set Size**: _____ complexes

### Performance Comparison

| Metric | DiffDock | DiffDock-L | Improvement |
|--------|----------|------------|-------------|
| Top-1 Success Rate (< 2Å) | ___% | ___% | ___% |
| Top-5 Success Rate (< 2Å) | ___% | ___% | ___% |
| Top-10 Success Rate (< 2Å) | ___% | ___% | ___% |
| Mean RMSD (Å) | ___ | ___ | ___ |
| Median RMSD (Å) | ___ | ___ | ___ |
| Mean runtime per complex | ___s | ___s | ___s |
| Model size (parameters) | ___M | ___M | ___% |

### Key Differences in DiffDock-L
_What changed between versions?_
1. **Architecture changes**:
2. **Training improvements**:
3. **New features**:

### Recommendation
_Which version should users choose and why?_
-
-

---

## 4. Ablation Study: Inference Steps

### Experimental Setup
- **Model**: DiffDock
- **Dataset**: Subset of test set (_____ complexes)
- **Variable**: Number of inference steps
- **Tested values**: 5, 10, 20, 40

### Results

| Inference Steps | Top-1 Success (%) | Mean RMSD (Å) | Runtime (s/complex) | Speedup vs 20 |
|----------------|-------------------|---------------|---------------------|---------------|
| 5 | ___% | ___ | ___ | ___x |
| 10 | ___% | ___ | ___ | ___x |
| 20 (paper) | ___% | ___ | ___ | 1.0x |
| 40 | ___% | ___ | ___ | ___x |

### Visualization
_Include plots:_
- Accuracy vs inference steps
- Runtime vs inference steps
- Accuracy-speed trade-off curve

### Analysis
**Key Findings:**
1. Diminishing returns after ___ steps
2. Optimal trade-off at ___ steps because ___
3.

**Recommendations:**
- For high accuracy: Use ___ steps
- For fast screening: Use ___ steps
- For balanced performance: Use ___ steps

---

## 5. Failure Analysis (Optional)

### Worst Performing Cases

| Complex ID | RMSD (Å) | Protein Type | Ligand MW | Rotatable Bonds | Binding Pocket Size |
|-----------|----------|--------------|-----------|-----------------|---------------------|
| | | | | | |
| | | | | | |
| | | | | | |

### Common Failure Patterns

#### Protein Characteristics
- Large proteins (>500 residues): ___% failure rate
- Multi-domain proteins: ___% failure rate
- Flexible proteins: ___% failure rate

#### Ligand Characteristics
- Large ligands (MW > 500): ___% failure rate
- Highly flexible (>10 rot bonds): ___% failure rate
- Charged ligands: ___% failure rate

#### Binding Site Characteristics
- Deep buried pockets: ___% failure rate
- Surface binding: ___% failure rate
- Multiple binding sites: ___% failure rate

### DiffDock vs Vina Failure Modes

**Both methods fail:**
-
-

**Only DiffDock fails:**
-
-

**Only Vina fails:**
-
-

### Insights
_What makes a complex "hard" for DiffDock?_
-
-

---

## 6. Confidence Model Evaluation (Optional)

### Correlation Analysis

| Metric | Value |
|--------|-------|
| Pearson correlation (confidence vs RMSD) | ___ |
| Spearman correlation | ___ |
| Kendall's tau | ___ |

### Confidence as Predictor

| Threshold | Precision | Recall | F1-Score |
|-----------|-----------|--------|----------|
| Top 10% confident | ___% | ___% | ___ |
| Top 25% confident | ___% | ___% | ___ |
| Top 50% confident | ___% | ___% | ___ |

### ROC Analysis
- AUC for predicting success (< 2Å): ___

### Practical Utility
_Can confidence scores be used to filter predictions?_
-
-

---

## 7. Statistical Significance Testing

### Methods Comparison (DiffDock vs Vina)
- **Test used**: Wilcoxon signed-rank test / paired t-test
- **p-value**: ___
- **Effect size (Cohen's d)**: ___
- **Conclusion**: Difference is statistically significant (yes/no) at α = 0.05

### Version Comparison (DiffDock vs DiffDock-L)
- **Test used**: ___
- **p-value**: ___
- **Effect size**: ___
- **Conclusion**: ___

---

## 8. Summary of Key Findings

### Main Results
1. **Reproduction**: Successfully reproduced paper results? (Yes/No) - within ___% margin
2. **vs Baseline**: DiffDock is ___x more accurate and ___x faster than Vina
3. **Version improvement**: DiffDock-L improves accuracy by ___% over original
4. **Optimal settings**: ___ inference steps provides best accuracy-speed trade-off

### Novel Contributions
_What unique insights did your experiments provide?_
1.
2.
3.

### Limitations Found
1.
2.
3.

### Future Work Suggestions
1.
2.
3.

---

## 9. Figures for Report

### Required Figures
- [ ] Figure 1: Success rate comparison (DiffDock vs baselines)
- [ ] Figure 2: RMSD distribution boxplot
- [ ] Figure 3: Runtime comparison bar chart
- [ ] Figure 4: Ablation study - accuracy vs inference steps
- [ ] Figure 5: Example successful docking visualization
- [ ] Figure 6: Example failure case visualization

### Optional Figures
- [ ] DiffDock vs DiffDock-L comparison
- [ ] Confidence vs RMSD scatter plot
- [ ] Failure analysis by ligand/protein properties
- [ ] ROC curve for confidence model

---

## 10. Tables for Report

### Required Tables
- [ ] Table 1: Dataset statistics
- [ ] Table 2: Method comparison (performance metrics)
- [ ] Table 3: Runtime and computational requirements
- [ ] Table 4: Ablation study results

### Optional Tables
- [ ] DiffDock vs DiffDock-L detailed comparison
- [ ] Failure case characteristics
- [ ] Statistical significance tests

---

## Report Sections Mapping

Use these results to populate report sections:

### Introduction
- Cite baseline performance (from Section 2)
- Mention key advantages found

### Methods
- Reference experimental setup from each section
- Include parameter tables

### Results
- Section 3.1: Reproduction (from Section 1)
- Section 3.2: Baseline Comparison (from Section 2)
- Section 3.3: DiffDock-L Analysis (from Section 3)
- Section 3.4: Ablation Study (from Section 4)
- Section 3.5: Failure Analysis (from Section 5)

### Discussion
- Interpret findings from Section 8
- Discuss limitations
- Suggest future work

---

## Checklist Before Finalizing

Data Quality:
- [ ] All experiments run on same test set (or documented subset)
- [ ] No data leakage
- [ ] Reproducible (seeds documented)
- [ ] Results verified (spot checks)

Statistical Rigor:
- [ ] Sample sizes documented
- [ ] Statistical tests performed
- [ ] Confidence intervals reported (where applicable)
- [ ] Multiple testing correction applied (if needed)

Presentation:
- [ ] All tables complete
- [ ] All figures generated
- [ ] Error bars shown where appropriate
- [ ] Consistent formatting
- [ ] Clear captions

Documentation:
- [ ] Methods clearly described
- [ ] Parameters documented
- [ ] Software versions recorded
- [ ] Hardware specifications noted
- [ ] Code/scripts archived

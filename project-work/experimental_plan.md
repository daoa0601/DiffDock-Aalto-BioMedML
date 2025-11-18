# DiffDock Experimental Plan

## Overview
This document outlines the experimental plan for evaluating DiffDock for the Machine Learning for Biomedicine project report.

---

## MUST DO Experiments

### 1. Reproduce Original Paper Results
**Objective**: Validate implementation and establish baseline performance

**Dataset**: PDBBind test set (time-based split)

**Steps**:
1. Download PDBBind processed data from Zenodo
2. Generate ESM2 embeddings for test set proteins
3. Run DiffDock inference on test set
4. Calculate success rates (top-1, top-5, top-10 at 2Å RMSD threshold)

**Commands**:
```bash
# 1. Download data (if not already done)
# See DiffDock/README.md for zenodo link

# 2. Generate ESM2 embeddings for test set
cd DiffDock
python datasets/esm_embedding_preparation.py --protein_ligand_csv data/testset_csv.csv --out_file data/prepared_for_esm_testset.fasta

# 3. Extract embeddings (requires ESM repository)
cd ../
git clone https://github.com/facebookresearch/esm
cd esm && pip install -e . && cd ..
HOME=esm/model_weights python esm/scripts/extract.py esm2_t33_650M_UR50D DiffDock/data/prepared_for_esm_testset.fasta DiffDock/data/esm2_output --repr_layers 33 --include per_tok

# 4. Run inference
cd DiffDock
python -m inference --protein_ligand_csv data/testset_csv.csv --out_dir ../project-work/results/diffdock_testset --inference_steps 20 --samples_per_complex 40 --batch_size 10 --actual_steps 18 --no_final_step_noise

# 5. Evaluate results
python evaluate_files.py --results_path ../project-work/results/diffdock_testset --file_to_exclude rank1.sdf --num_predictions 40
```

**Expected Output**:
- Top-1 success rate: ~38% (± 2%)
- Top-5 success rate: ~55-60%
- Top-10 success rate: ~65-70%

**Deliverables**:
- Results CSV with RMSD values
- Success rate statistics
- Runtime measurements

---

### 2. Baseline Comparison: AutoDock Vina
**Objective**: Compare DiffDock against traditional docking method

**Why AutoDock Vina**: Most widely used, easy to install, well-documented baseline

**Dataset**: Same PDBBind test set (or subset if time-limited)

**Steps**:
1. Install AutoDock Vina
2. Prepare protein and ligand files (convert to PDBQT format)
3. Run docking for each complex
4. Evaluate using same metrics as DiffDock

**Installation**:
```bash
# Install via conda
conda install -c conda-forge vina

# Or download binary from official site
# http://vina.scripps.edu/
```

**Workflow**:
```bash
# For each complex:
# 1. Prepare receptor (protein)
prepare_receptor4.py -r protein.pdb -o protein.pdbqt

# 2. Prepare ligand
prepare_ligand4.py -l ligand.sdf -o ligand.pdbqt

# 3. Run Vina (blind docking - search whole protein)
vina --receptor protein.pdbqt --ligand ligand.pdbqt --out output.pdbqt --exhaustiveness 8

# 4. Calculate RMSD against crystal structure
```

**Comparison Metrics**:
- Success rate at 2Å RMSD (top-1, top-5, top-10)
- Average RMSD of top pose
- Runtime per complex
- Memory usage

**Deliverables**:
- Vina results for test set
- Comparative table: DiffDock vs Vina
- Runtime comparison chart

---

## SHOULD DO Experiments

### 3. DiffDock vs DiffDock-L Comparison
**Objective**: Evaluate improvements in 2024 version (DiffDock-L)

**Unique Value**: This is a novel contribution not in the original paper!

**Dataset**: Same test set or representative subset

**Steps**:
1. Set up DiffDock-L environment (may have different dependencies)
2. Run same test set through both versions
3. Compare accuracy, speed, and confidence scores

**Commands**:
```bash
# Run DiffDock-L (check DiffDockL/README.md for specific commands)
cd DiffDockL
# Similar commands as DiffDock but check for parameter differences
python -m inference --protein_ligand_csv ../DiffDock/data/testset_csv.csv --out_dir ../project-work/results/diffdockL_testset --inference_steps 20 --samples_per_complex 40 --batch_size 10
```

**Analysis**:
- Side-by-side accuracy comparison
- What changed between versions?
- Are improvements significant?
- Trade-offs (if any)?

**Deliverables**:
- Comparison table: DiffDock vs DiffDock-L
- Analysis of improvements
- Recommendations for which version to use

---

## NICE TO HAVE Experiments

### 4. Ablation Study: Inference Steps
**Objective**: Understand impact of diffusion steps on accuracy vs speed

**Experiment Design**:
Test different numbers of inference steps: 5, 10, 20, 40

**Dataset**: Subset of test set (~50-100 complexes for speed)

**Commands**:
```bash
# Test with 5 steps
python -m inference --protein_ligand_csv data/testset_subset.csv --out_dir ../project-work/results/ablation_steps5 --inference_steps 5 --samples_per_complex 40 --batch_size 10

# Test with 10 steps
python -m inference --protein_ligand_csv data/testset_subset.csv --out_dir ../project-work/results/ablation_steps10 --inference_steps 10 --samples_per_complex 40 --batch_size 10

# Test with 20 steps (paper default)
python -m inference --protein_ligand_csv data/testset_subset.csv --out_dir ../project-work/results/ablation_steps20 --inference_steps 20 --samples_per_complex 40 --batch_size 10

# Test with 40 steps
python -m inference --protein_ligand_csv data/testset_subset.csv --out_dir ../project-work/results/ablation_steps40 --inference_steps 40 --samples_per_complex 40 --batch_size 10
```

**Analysis**:
- Plot accuracy vs inference steps
- Plot runtime vs inference steps
- Identify optimal trade-off point

**Deliverables**:
- Accuracy vs steps plot
- Runtime vs steps plot
- Analysis of diminishing returns

---

## Additional Valuable Experiments (Time Permitting)

### 5. Failure Analysis
**Objective**: Understand when and why DiffDock fails

**Steps**:
1. Identify worst-performing cases (highest RMSD)
2. Analyze common characteristics:
   - Protein size/family
   - Ligand properties (size, flexibility, rotatable bonds)
   - Binding pocket characteristics
3. Compare failures with Vina failures (different failure modes?)

**Deliverables**:
- List of failure cases with analysis
- Hypothesis on what makes complexes "hard"
- Comparison with baseline failure modes

### 6. Confidence Model Evaluation
**Objective**: Validate confidence scoring effectiveness

**Analysis**:
- Correlation between confidence score and RMSD
- ROC curve for pose ranking
- Does top confidence = top accuracy?

**Deliverables**:
- Scatter plot: confidence vs RMSD
- ROC/AUC metrics
- Analysis of confidence reliability

---

## Timeline Recommendation

**Week 1-2**:
- Set up environments (DiffDock, DiffDock-L, Vina)
- Download and prepare datasets
- Run MUST DO #1: Reproduce paper results

**Week 3**:
- Run MUST DO #2: Vina baseline
- Begin SHOULD DO #3: DiffDock vs DiffDock-L

**Week 4**:
- Complete comparisons
- Run NICE TO HAVE #4: Ablation study
- Start analysis and writing

**Week 5-6**:
- Failure analysis (if time)
- Finalize results
- Write report

---

## Resources Needed

**Computational**:
- GPU recommended (inference is slow on CPU)
- ~50-100 GB disk space for datasets
- ~16-32 GB RAM

**Software**:
- Python 3.9+
- PyTorch with CUDA
- ESM (for embeddings)
- AutoDock Vina
- RDKit, BioPython

**Data**:
- PDBBind processed dataset (~20 GB)
- ESM2 model weights (auto-downloaded)

---

## Notes and Tips

1. **Start Early**: Data download and ESM embedding generation can take hours
2. **Document Everything**: Keep logs of all commands run
3. **Version Control**: Use git to track experiment scripts
4. **Sanity Checks**: Test on 1-2 complexes before running full dataset
5. **Save Intermediate Results**: Don't re-run expensive computations
6. **Statistical Significance**: Run multiple seeds if possible
7. **Visualization**: Good figures make reports stand out

---

## Expected Report Sections from Experiments

**From MUST DO**:
- Reproduction of paper results (validates methodology)
- Baseline comparison table (shows DiffDock's advantages)

**From SHOULD DO**:
- DiffDock evolution analysis (unique contribution!)

**From NICE TO HAVE**:
- Ablation study insights (shows deep understanding)
- Failure analysis (critical thinking)

---

## Success Criteria

**Minimum for good report**:
- ✓ Reproduced paper results (within reasonable margin)
- ✓ 1-2 baseline comparisons with clear analysis
- ✓ Well-documented methodology
- ✓ Clear presentation of results

**For excellent report**:
- ✓ All of above
- ✓ DiffDock vs DiffDock-L analysis
- ✓ Ablation study with insights
- ✓ Failure analysis with examples
- ✓ Statistical significance testing
- ✓ Professional figures and tables

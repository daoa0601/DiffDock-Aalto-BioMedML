# Preliminary Project Report Tasks for DiffDock Evaluation

Based on the provided documents (`README.md`, `ml_biomed_draft1-1.pdf`, and `project_biomed.md`), here is a list of tasks for your preliminary project report:

**1. Flesh out the Introduction and Motivation:**
*   Expand on the abstract from your draft (`ml_biomed_draft1-1.pdf`).
*   Explain the importance of molecular docking in drug discovery.
*   Introduce DiffDock as a novel diffusion-based model and briefly state its advantages over traditional methods, as mentioned in your abstract.

**2. Describe the DiffDock Algorithm:**
*   Study the original DiffDock paper ("DiffDock: Diffusion Steps, Twists, and Turns for Molecular Docking") mentioned in your draft.
*   Write a detailed section for your report explaining the model's architecture and the diffusion process it uses to predict ligand binding structures.

**3. Select and Prepare Datasets:**
*   Your `README.md` and draft mention the PDBBind dataset. You need to formally decide if you will use this, or other datasets mentioned like BindingMOAD or PoseBusters.
*   Follow the instructions in the `README.md` under the "Datasets" and "Replicate results" sections to download and process the data. This includes:
    *   Downloading the processed complexes from Zenodo.
    *   Generating and caching the ESM2 embeddings for the proteins.

**4. Identify and Set Up Baseline Models:**
*   The project requires comparison to baseline methods, as outlined in `project_biomed.md`. Your abstract mentions "traditional search-based methods and previous deep learning approaches."
*   Consult the original DiffDock paper to identify the specific baseline models they compared against.
*   Find implementations of these baseline models and set them up for evaluation on your chosen dataset.

**5. Run Experiments and Collect Results:**
*   Use the instructions in the `README.md` under "Replicate results" to run the evaluation script (`evaluate.py`) for DiffDock on the test splits.
*   Run the baseline models on the same dataset to gather their performance metrics.
*   Your goal is to reproduce the results mentioned in the paper (like the 38% top-1 success rate on PDBBind) and generate corresponding results for the baselines.

**6. Structure and Write the Preliminary Report:**
*   Use the specified LaTeX template (Bioinformatics journal style) as per `project_biomed.md`.
*   Create sections for:
    *   Introduction
    *   Methods (describing DiffDock and the chosen baseline models)
    *   Datasets (describing PDBBind or other selected data)
    *   Preliminary Results (presenting the metrics you have collected so far)
*   The final report needs to be 6-10 pages, so plan the content accordingly.

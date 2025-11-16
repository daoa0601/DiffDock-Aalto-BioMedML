# DiffDock Project Explanation

This document provides a detailed explanation of the DiffDock project, a state-of-the-art method for molecular docking. It outlines the purpose of each file and directory within this repository.

## Project Overview

DiffDock is a diffusion-based model for molecular docking, which predicts the 3D structure of a protein-ligand complex. It frames molecular docking as a generative modeling problem, using a diffusion process to predict the binding structure of small molecule ligands to proteins. This approach has shown significant improvements over traditional search-based methods and previous deep learning approaches.

---

## Root Directory

Files in the root directory are primarily for running the main functionalities of the project, configuration, and documentation.

*   `.dockerignore`: Specifies files and directories to ignore when building the Docker image.
*   `.gitattributes`: A Git file to specify attributes for pathnames.
*   `.gitignore`: A Git file to specify untracked files that Git should ignore.
*   `default_inference_args.yaml`: Default arguments for running inference.
*   `Dockerfile`: For building a Docker container with the necessary environment and dependencies to run DiffDock.
*   `environment.yml`: A Conda environment file that lists the dependencies required to run the project.
*   `evaluate.py`: The main script for evaluating the model's performance on a given dataset.
*   `inference.py`: The main script for running inference (docking prediction) on a single or multiple protein-ligand complexes.
*   `LICENSE`: The license for the project (MIT License).
*   `ml_biomed_draft1-1.pdf`: A draft of the project report for the "Machine Learning for Biomedicine" course.
*   `overview.png`: An image providing an overview of the DiffDock method.
*   `project_biomed.md`: The project description and requirements for the "Machine Learning for Biomedicine" course.
*   `README.md`: The main README file for this repository, describing the project for the "Machine Learning for Biomedicine" course.
*   `DiffDock.md`: The original README from the DiffDock repository.
*   `requirements.txt`: A pip requirements file listing the Python dependencies.
*   `tasks.md`: A file listing the tasks for the "Machine learning for Biomedicine" course project.
*   `train.py`: The main script for training the DiffDock model.

---

## app Directory

This directory contains the code for a simple Gradio-based web interface to run DiffDock.

*   `__init__.py`: Makes the `app` directory a Python package.
*   `Dockerfile`: A Dockerfile to build a container for the web application.
*   `main.py`: The main script to run the Gradio web interface.
*   `mol_viewer.py`: A utility for visualizing molecules in the web interface.
*   `README.md`: A README file for the web application.
*   `requirements.txt`: A pip requirements file for the web application.
*   `run_utils.py`: Utility functions for running the docking prediction from the web interface.

---

## confidence Directory

This directory contains the code for training and using the confidence model, which predicts the confidence of the docking prediction.

*   `__init__.py`: Makes the `confidence` directory a Python package.
*   `confidence_train.py`: The main script for training the confidence model.
*   `dataset.py`: The dataset loader for the confidence model training.

---

## data Directory

This directory contains example data and data splits for training and evaluation.

*   `protein_ligand_example.csv`: An example CSV file for running inference on multiple protein-ligand complexes.
*   `testset_csv.csv`: A CSV file for the test set.
*   `1a0q/`: An example directory containing a protein-ligand complex.
*   `splits/`: This directory contains files that define the data splits for training, validation, and testing.

---

## datasets Directory

This directory contains scripts for processing and preparing datasets.

*   `__init__.py`: Makes the `datasets` directory a Python package.
*   `conformer_matching.py`: A script for matching conformers.
*   `constants.py`: Contains constants used in the dataset processing.
*   `dataloader.py`: The main data loader for the project.
*   `esm_embedding_preparation.py`: A script to prepare protein sequences for ESM embedding generation.
*   `esm_embeddings_to_pt.py`: A script to convert ESM embeddings to PyTorch tensors.
*   `loader.py`: Contains data loading utilities.
*   `moad.py`: A script for processing the Binding MOAD dataset.
*   `parse_chi.py`: A script for parsing chi angles.
*   `pdb.py`: A script for processing PDB files.
*   `pdbbind.py`: A script for processing the PDBbind dataset.
*   `process_mols.py`: A script for processing molecules.
*   `sidechain_esm_embeddings_to_pt.py`: A script to convert sidechain ESM embeddings to PyTorch tensors.

---

## examples Directory

This directory contains example protein and ligand files for testing the docking prediction.

---

## models Directory

This directory contains the implementation of the DiffDock model and its components.

*   `__init__.py`: Makes the `models` directory a Python package.
*   `aa_model.py`: The all-atom model.
*   `cg_model.py`: The coarse-grained model.
*   `layers.py`: Custom neural network layers used in the models.
*   `old_aa_model.py`: An older version of the all-atom model.
*   `old_cg_model.py`: An older version of the coarse-grained model.
*   `tensor_layers.py`: Custom tensor layers for the models.

---

## spyrmsd Directory

This directory contains the `spyrmsd` package, a tool for calculating the Root-Mean-Square Deviation (RMSD) of molecules.

---

## utils Directory

This directory contains various utility functions used throughout the project.

*   `__init__.py`: Makes the `utils` directory a Python package.
*   `diffusion_utils.py`: Utility functions for the diffusion process.
*   `download.py`: A script for downloading files.
*   `geometry.py`: Utility functions for geometric calculations.
*   `gnina_utils.py`: Utility functions for using GNINA.
*   `inference_utils.py`: Utility functions for running inference.
*   `logging_utils.py`: Utility functions for logging.
*   `molecules_utils.py`: Utility functions for working with molecules.
*   `parsing.py`: Utility functions for parsing files and arguments.
*   `precompute_series.py`: A script for precomputing series.
*   `print_device.py`: A script to print the device (CPU/GPU) being used.
*   `sampling.py`: Utility functions for sampling.
*   `so3.py`: Utility functions for working with SO(3) rotations.
*   `torsion.py`: Utility functions for torsion angle calculations.
*   `torus.py`: Utility functions for working with tori.
*   `training.py`: Utility functions for training the model.
*   `utils.py`: General utility functions.
*   `visualise.py`: Utility functions for visualizing results.

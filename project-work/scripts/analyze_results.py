#!/usr/bin/env python3
"""
Script to analyze and compare DiffDock experiment results
Usage: python analyze_results.py --results_dir ../results --experiments exp1 exp2 exp3
"""

import argparse
import os
import pandas as pd
import json
from pathlib import Path
from typing import List, Dict
import numpy as np

def load_experiment_results(results_dir: Path, experiment_name: str) -> Dict:
    """Load results from a single experiment"""
    exp_path = results_dir / experiment_name

    if not exp_path.exists():
        print(f"Warning: {exp_path} does not exist")
        return None

    results = {
        'name': experiment_name,
        'path': str(exp_path),
    }

    # Look for common result files
    # Adjust based on actual DiffDock output format

    # Check for evaluation CSV
    eval_files = list(exp_path.glob('*evaluation*.csv'))
    if eval_files:
        df = pd.read_csv(eval_files[0])
        results['data'] = df
        results['eval_file'] = str(eval_files[0])

    # Check for log file
    log_files = list(exp_path.glob('*.log'))
    if log_files:
        results['log_file'] = str(log_files[0])

    return results

def calculate_success_rate(rmsd_values: np.ndarray, threshold: float = 2.0) -> float:
    """Calculate success rate (percentage below threshold)"""
    return (rmsd_values < threshold).sum() / len(rmsd_values) * 100

def analyze_single_experiment(results: Dict) -> Dict:
    """Analyze results from a single experiment"""
    if results is None or 'data' not in results:
        return None

    df = results['data']

    # Assuming the dataframe has RMSD values
    # Adjust column names based on actual DiffDock output

    analysis = {
        'experiment': results['name'],
        'num_complexes': len(df),
    }

    # Try to find RMSD columns (adjust based on actual format)
    rmsd_cols = [col for col in df.columns if 'rmsd' in col.lower()]

    if rmsd_cols:
        # If multiple RMSD columns (top-1, top-5, etc.)
        for col in rmsd_cols:
            rmsd_values = df[col].values
            rmsd_values = rmsd_values[~np.isnan(rmsd_values)]  # Remove NaN

            if len(rmsd_values) > 0:
                analysis[f'{col}_mean'] = rmsd_values.mean()
                analysis[f'{col}_median'] = np.median(rmsd_values)
                analysis[f'{col}_success_2A'] = calculate_success_rate(rmsd_values, 2.0)
                analysis[f'{col}_success_5A'] = calculate_success_rate(rmsd_values, 5.0)

    return analysis

def compare_experiments(experiments: List[Dict]) -> pd.DataFrame:
    """Create comparison table of multiple experiments"""
    analyses = []

    for exp in experiments:
        analysis = analyze_single_experiment(exp)
        if analysis:
            analyses.append(analysis)

    if not analyses:
        return None

    return pd.DataFrame(analyses)

def main():
    parser = argparse.ArgumentParser(description='Analyze DiffDock experiment results')
    parser.add_argument('--results_dir', type=str, default='../results',
                        help='Directory containing experiment results')
    parser.add_argument('--experiments', nargs='+', required=True,
                        help='List of experiment names to analyze')
    parser.add_argument('--output', type=str, default='../tables/comparison.csv',
                        help='Output file for comparison table')
    parser.add_argument('--threshold', type=float, default=2.0,
                        help='RMSD threshold for success rate (Angstroms)')

    args = parser.parse_args()

    results_dir = Path(args.results_dir)

    if not results_dir.exists():
        print(f"Error: Results directory {results_dir} does not exist")
        return

    print(f"Analyzing experiments: {args.experiments}")
    print(f"Results directory: {results_dir}")
    print()

    # Load all experiments
    experiments = []
    for exp_name in args.experiments:
        print(f"Loading {exp_name}...")
        exp_results = load_experiment_results(results_dir, exp_name)
        if exp_results:
            experiments.append(exp_results)

    if not experiments:
        print("No valid experiments found!")
        return

    print(f"\nLoaded {len(experiments)} experiments")
    print()

    # Create comparison table
    print("Analyzing and comparing results...")
    comparison_df = compare_experiments(experiments)

    if comparison_df is not None:
        print("\n" + "="*80)
        print("COMPARISON RESULTS")
        print("="*80)
        print(comparison_df.to_string())
        print("="*80)

        # Save to file
        output_path = Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        comparison_df.to_csv(output_path, index=False)
        print(f"\nResults saved to: {output_path}")
    else:
        print("Could not create comparison table")

    # Individual experiment details
    print("\n" + "="*80)
    print("INDIVIDUAL EXPERIMENT DETAILS")
    print("="*80)

    for exp in experiments:
        print(f"\nExperiment: {exp['name']}")
        print(f"Path: {exp['path']}")
        if 'eval_file' in exp:
            print(f"Evaluation file: {exp['eval_file']}")
        if 'log_file' in exp:
            print(f"Log file: {exp['log_file']}")

        analysis = analyze_single_experiment(exp)
        if analysis:
            print(json.dumps(analysis, indent=2))

if __name__ == '__main__':
    main()

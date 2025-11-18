#!/usr/bin/env python3
"""
Script to analyze ablation study results
Specifically designed for analyzing the effect of different inference steps
"""

import argparse
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path
import numpy as np

sns.set_style('whitegrid')

def analyze_ablation(results_dir: Path, steps_list: list, output_dir: Path):
    """Analyze ablation study across different inference steps"""

    results = []

    for steps in steps_list:
        exp_name = f"ablation_steps{steps}"
        exp_path = results_dir / exp_name

        if not exp_path.exists():
            print(f"Warning: {exp_path} does not exist, skipping...")
            continue

        # Find evaluation file
        eval_files = list(exp_path.glob('*evaluation*.csv'))
        if not eval_files:
            print(f"Warning: No evaluation file found in {exp_path}")
            continue

        df = pd.read_csv(eval_files[0])

        # Calculate metrics (adjust based on actual column names)
        result = {
            'inference_steps': steps,
            'num_complexes': len(df),
        }

        # Find RMSD columns
        rmsd_cols = [col for col in df.columns if 'rmsd' in col.lower()]

        for col in rmsd_cols:
            rmsd_values = df[col].values
            rmsd_values = rmsd_values[~np.isnan(rmsd_values)]

            if len(rmsd_values) > 0:
                result[f'{col}_mean'] = rmsd_values.mean()
                result[f'{col}_median'] = np.median(rmsd_values)
                result[f'{col}_success_2A'] = (rmsd_values < 2.0).sum() / len(rmsd_values) * 100

        # Try to extract runtime from log
        log_files = list(exp_path.glob('*.log'))
        if log_files:
            result['log_file'] = str(log_files[0])
            # You could parse runtime from log here

        results.append(result)

    if not results:
        print("No valid results found!")
        return

    results_df = pd.DataFrame(results)
    results_df = results_df.sort_values('inference_steps')

    print("\n" + "="*80)
    print("ABLATION STUDY RESULTS: Inference Steps")
    print("="*80)
    print(results_df.to_string(index=False))
    print("="*80)

    # Save table
    output_dir.mkdir(parents=True, exist_ok=True)
    table_path = output_dir / 'ablation_inference_steps.csv'
    results_df.to_csv(table_path, index=False)
    print(f"\nTable saved to: {table_path}")

    # Create plots
    create_ablation_plots(results_df, output_dir)

def create_ablation_plots(df: pd.DataFrame, output_dir: Path):
    """Create visualization plots for ablation study"""

    # Find success rate column (adjust based on actual column names)
    success_cols = [col for col in df.columns if 'success' in col.lower() and '2A' in col]

    if not success_cols:
        print("Warning: Could not find success rate columns for plotting")
        return

    # Plot 1: Success rate vs inference steps
    fig, axes = plt.subplots(1, 2, figsize=(14, 5))

    # Success rate plot
    ax1 = axes[0]
    for col in success_cols:
        ax1.plot(df['inference_steps'], df[col], marker='o', linewidth=2, markersize=8, label=col)

    ax1.set_xlabel('Number of Inference Steps', fontsize=12)
    ax1.set_ylabel('Success Rate (%)', fontsize=12)
    ax1.set_title('Success Rate vs Inference Steps', fontsize=14, fontweight='bold')
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Mean RMSD plot
    ax2 = axes[1]
    rmsd_mean_cols = [col for col in df.columns if 'mean' in col.lower() and 'rmsd' in col.lower()]

    for col in rmsd_mean_cols[:1]:  # Plot first RMSD mean column
        ax2.plot(df['inference_steps'], df[col], marker='s', linewidth=2, markersize=8, color='coral')

    ax2.set_xlabel('Number of Inference Steps', fontsize=12)
    ax2.set_ylabel('Mean RMSD (Å)', fontsize=12)
    ax2.set_title('Mean RMSD vs Inference Steps', fontsize=14, fontweight='bold')
    ax2.grid(True, alpha=0.3)

    plt.tight_layout()
    plot_path = output_dir / 'ablation_inference_steps.png'
    plt.savefig(plot_path, dpi=300, bbox_inches='tight')
    print(f"Plot saved to: {plot_path}")
    plt.close()

    # Plot 2: Trade-off analysis (if runtime data available)
    # This would show accuracy vs speed trade-off
    # You can add this if you extract runtime from logs

def main():
    parser = argparse.ArgumentParser(description='Analyze ablation study results')
    parser.add_argument('--results_dir', type=str, default='../results',
                        help='Directory containing experiment results')
    parser.add_argument('--steps', nargs='+', type=int, default=[5, 10, 20, 40],
                        help='List of inference steps tested')
    parser.add_argument('--output_dir', type=str, default='../figures',
                        help='Directory for output figures and tables')

    args = parser.parse_args()

    results_dir = Path(args.results_dir)
    output_dir = Path(args.output_dir)

    print("Ablation Study Analysis")
    print(f"Results directory: {results_dir}")
    print(f"Testing inference steps: {args.steps}")
    print(f"Output directory: {output_dir}")
    print()

    analyze_ablation(results_dir, args.steps, output_dir)

if __name__ == '__main__':
    main()

# analyze_with_ci.py
#
# This script analyzes the raw experimental data from the semantic_roundtrip_benchmark,
# calculates success rates for each condition, and computes the 95% confidence intervals
# for these rates using the Wilson score interval method.
#
# Prerequisite: Install necessary libraries
# pip install pandas statsmodels
#
import os
import json
import pandas as pd
from statsmodels.stats.proportion import proportion_confint
import re

def analyze_results(data_dir):
    """
    Analyzes all result.json files in the data directory, calculates success rates
    and 95% confidence intervals.
    """
    results = []

    # This regex now captures the test case name (e.g., get_magic_number, fizzbuzz)
    pattern = re.compile(r'([a-zA-Z0-9_.:-]+)_((?:en|ja))_([a-zA-Z_]+)_([a-zA-Z_]+)_(get_magic_number|fizzbuzz|process_user_list|separate_vowels_and_consonants)_run\d+')

    for root, dirs, files in os.walk(data_dir):
        if 'result.json' in files:
            dir_name = os.path.basename(root)
            parent_dir_name = os.path.basename(os.path.dirname(root))

            test_type_str = None
            n_str = None
            parts = parent_dir_name.split('_')

            # Handle the new adaptive format, e.g., adaptive_composite_n30_process_user_list_20260101_100830
            if parent_dir_name.startswith("adaptive_"):
                if len(parts) >= 4:
                    test_type_str = parts[1]
                    n_str = parts[2][1:] # Remove 'n'
            # Handle the fizzbuzz format, e.g., run_fizzbuzz_forgiving_20251231_104355
            elif parent_dir_name.startswith("run_fizzbuzz"):
                if "forgiving" in parent_dir_name:
                    test_type_str = "forgiving"
                elif "strict" in parent_dir_name:
                    test_type_str = "strict"
                n_str = "30" # This run was with N=30
            # Handle high-rep get_magic_number format, e.g., run_high_rep_strict_n3_20260103_145801
            elif parent_dir_name.startswith("run_high_rep_"):
                if len(parts) >= 5:
                    test_type_str = parts[3]
                    n_str = parts[4][1:] # Remove 'n'
            # Handle llama3-8b tests, e.g., llm_test_llama3-8b_20260101_231634
            elif parent_dir_name.startswith("llm_test_"):
                test_type_str = "standard" # This run has no strict/forgiving mode distinction
                n_str = "30" # This run was with N=30
            # Handle original formats, e.g., forgiving_n_30_20251229_183244
            elif "_n_" in parent_dir_name:
                if len(parts) >= 3:
                    test_type_str = parts[0]
                    n_str = parts[2]
            
            if not test_type_str or not n_str:
                print(f"Skipping directory with unrecognized parent format: {parent_dir_name}")
                continue
            
            match = pattern.match(dir_name)
            if not match:
                print(f"Skipping directory with unexpected format: {dir_name}")
                continue
                
            model, lang, spec, prompt_style, test_case = match.groups()

            result_path = os.path.join(root, 'result.json')
            with open(result_path, 'r') as f:
                try:
                    data = json.load(f)
                    success = "SUCCESS" in data.get('status', '')
                    
                    results.append({
                        'model': model,
                        'test_case': test_case,
                        'n_type': f"n={n_str}",
                        'test_type': test_type_str,
                        'lang': lang,
                        'spec': spec,
                        'prompt_style': prompt_style,
                        'success': 1 if success else 0
                    })
                except json.JSONDecodeError:
                    print(f"Error decoding JSON in {result_path}")
                    continue

    if not results:
        print("No results found. Please check the data directory path.")
        return None

    df = pd.DataFrame(results)

    # Aggregate results, including by test_case
    summary = df.groupby(['model', 'test_case', 'n_type', 'test_type', 'lang', 'spec', 'prompt_style']).agg(
        trials=('success', 'count'),
        successes=('success', 'sum')
    ).reset_index()

    summary['success_rate'] = summary['successes'] / summary['trials']

    # Calculate confidence intervals
    conf_intervals = summary.apply(
        lambda row: proportion_confint(row['successes'], row['trials'], method='wilson'),
        axis=1
    )
    summary[['ci_lower', 'ci_upper']] = pd.DataFrame(conf_intervals.tolist(), index=summary.index)

    # Format for readability
    summary['success_rate_percent'] = summary['success_rate'] * 100
    summary['ci_lower_percent'] = summary['ci_lower'] * 100
    summary['ci_upper_percent'] = summary['ci_upper'] * 100
    
    summary['rate_with_ci'] = summary.apply(
        lambda row: f"{row['success_rate_percent']:.1f}% (95% CI: {row['ci_lower_percent']:.1f}-{row['ci_upper_percent']:.1f})",
        axis=1
    )

    return summary

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    DATA_DIRECTORY = os.path.join(script_dir, '..', '04_RawData')
    
    print(f"Analyzing data in: {DATA_DIRECTORY}")
    
    full_summary = analyze_results(DATA_DIRECTORY)
    
    if full_summary is not None:
        # Aggregate across lang, spec, prompt_style for a high-level summary
        agg_summary = full_summary.groupby(['model', 'test_case', 'n_type', 'test_type']).agg(
            trials=('trials', 'sum'),
            successes=('successes', 'sum')
        ).reset_index()

        # Recalculate CIs for the fully aggregated data
        conf_intervals_agg = agg_summary.apply(
            lambda row: proportion_confint(row['successes'], row['trials'], method='wilson'),
            axis=1
        )
        agg_summary[['ci_lower', 'ci_upper']] = pd.DataFrame(conf_intervals_agg.tolist(), index=agg_summary.index)
        agg_summary['success_rate'] = agg_summary['successes'] / agg_summary['trials']
        agg_summary['rate_with_ci'] = agg_summary.apply(
            lambda row: f"{(row['success_rate'] * 100):.1f}% (95% CI: {(row['ci_lower'] * 100):.1f}-{(row['ci_upper'] * 100):.1f})",
            axis=1
        )

        print("\n### High-Level Aggregated Results ###")
        print(agg_summary[['model', 'test_case', 'n_type', 'test_type', 'trials', 'successes', 'rate_with_ci']].sort_values(by=['model', 'test_case', 'test_type']))
        
        # Save to CSV
        output_path = os.path.join(script_dir, 'analysis_with_ci.csv')
        # Save the detailed summary (before high-level aggregation)
        full_summary.to_csv(output_path, index=False)
        print(f"\nDetailed analysis saved to {output_path}")

        # Save the aggregated summary as well
        agg_output_path = os.path.join(script_dir, 'analysis_aggregated.csv')
        agg_summary.to_csv(agg_output_path, index=False)
        print(f"Aggregated summary saved to {agg_output_path}")

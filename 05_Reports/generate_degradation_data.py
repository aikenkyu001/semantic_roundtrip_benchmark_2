
import json
import pandas as pd
import argparse
from pathlib import Path
import re

def parse_run_info(path: Path):
    """
    Parses the directory name to extract model, task, language, and other info.
    Example path: .../falcon3-3b_en_pseudocode_hyper_guided_fizzbuzz_run1/result.json
    """
    dir_name = path.parent.name
    parts = dir_name.split('_')
    
    # Handle model names that might contain hyphens, but the separator is the first underscore
    model_match = re.match(r"([a-zA-Z0-9.\-]+?)_([a-z]{2})_(.*)", dir_name)
    if not model_match:
        return None

    model = model_match.group(1)
    lang = model_match.group(2)
    
    # The rest of the string contains task, styles, and run number
    rest = model_match.group(3)

    # Extract task name
    if 'fizzbuzz' in rest:
        task = 'fizzbuzz'
    elif 'separate_vowels_and_consonants' in rest:
        task = 'separate_vowels_and_consonants'
    else:
        return None # Skip other tasks

    # We are only interested in the main experiment setup
    if 'pseudocode_hyper_guided' not in rest:
        return None

    return {
        "model": model,
        "task": task,
        "language": lang
    }

def calculate_survival_curve(df_group):
    """Calculates survival rate at each cycle for a group of runs."""
    total_runs = len(df_group)
    if total_runs == 0:
        return []

    survival_data = []
    max_cycles = 10 # As defined in the benchmark

    for cycle in range(1, max_cycles + 1):
        survived_runs = (df_group['cycles_completed'] >= cycle).sum()
        survival_rate = (survived_runs / total_runs) * 100
        survival_data.append({'cycle': cycle, 'survival_rate': survival_rate})

    return survival_data

def main(data_dirs, output_file):
    """
    Main function to aggregate data and generate the degradation curve CSV.
    """
    all_results = []
    print(f"Searching for 'result.json' in: {data_dirs}")

    for data_dir in data_dirs:
        base_path = Path(data_dir)
        for result_path in base_path.rglob('result.json'):
            run_info = parse_run_info(result_path)
            if not run_info:
                continue
            
            try:
                with open(result_path, 'r') as f:
                    result_data = json.load(f)
                
                cycles_completed = result_data.get('cycles_completed', 0)
                # If SUCCESS, it completed all 10 cycles and the loop for the 11th.
                if result_data.get('status') == 'SUCCESS':
                    cycles_completed = 10
                
                run_info['cycles_completed'] = cycles_completed
                all_results.append(run_info)
            except (json.JSONDecodeError, IOError) as e:
                print(f"Could not read or parse {result_path}: {e}")
                continue
    
    if not all_results:
        print("No valid result files found for the specified criteria.")
        return

    df = pd.DataFrame(all_results)
    print("\nSuccessfully parsed a total of {} result files.".format(len(df)))
    print("\nData distribution by model and task:")
    print(df.groupby(['model', 'task']).size().reset_index(name='counts'))


    # Calculate survival curves for each group
    curves = df.groupby(['model', 'task', 'language']).apply(calculate_survival_curve)
    
    # Flatten the data for CSV export
    output_data = []
    for (model, task, lang), curve_data in curves.items():
        for point in curve_data:
            output_data.append({
                'model': model,
                'task': task,
                'language': lang,
                'cycle': point['cycle'],
                'survival_rate': point['survival_rate']
            })

    output_df = pd.DataFrame(output_data)
    
    # Save to CSV
    output_df.to_csv(output_file, index=False)
    print(f"\nDegradation curve data successfully saved to {output_file}")
    print("\nPreview of the generated data:")
    print(output_df.head())


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate degradation curve data from benchmark results.')
    parser.add_argument('data_dirs', nargs='+', help='One or more directories containing raw experiment data.')
    parser.add_argument('--output-file', default='05_Reports/degradation_data.csv', help='Path to the output CSV file.')
    
    args = parser.parse_args()
    
    output_path = Path(args.output_file)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    main(args.data_dirs, output_path)

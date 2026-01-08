{generated_code}
import sys
import math

def run_tests():
    test_cases = [
        {
            "input": [
                {'name': 'Taro', 'scores': [80, 90, 95]},
                {'name': 'Hana', 'scores': [70, 65, 75]},
                {'name': 'Jiro', 'scores': []},
                {'name': 'Saburo', 'scores': [100, 95]}
            ],
            "expected": [
                "Taro: Average 88.3 (Rank: Good)",
                "Hana: Average 70.0 (Rank: Good)",
                "Jiro: Average 0.0 (Rank: N/A)",
                "Saburo: Average 95.0 (Rank: Excellent)"
            ]
        },
        {
            "input": [],
            "expected": []
        },
        {
            "input": [{'name': 'Single', 'scores': [50]}],
            "expected": ["Single: Average 50.0 (Rank: Fair)"]
        }
    ]

    try:
        if 'process_user_list' not in globals():
            print("FAIL: Function 'process_user_list' not found.")
            sys.exit(1)

        for i, case in enumerate(test_cases):
            actual_output = process_user_list(case["input"])
            
            if not isinstance(actual_output, list):
                print(f"FAIL: Test Case {i+1}: Output is not a list.")
                sys.exit(1)
            
            if len(actual_output) != len(case["expected"]):
                print(f"FAIL: Test Case {i+1}: Length of output list is incorrect. Expected {len(case['expected'])}, Got {len(actual_output)}")
                sys.exit(1)
            
            for j, (actual_line, expected_line) in enumerate(zip(actual_output, case["expected"])):
                 if actual_line != expected_line:
                    print(f"FAIL: Test Case {i+1}, Line {j+1}: Mismatch. Expected '{expected_line}', Got '{actual_line}'")
                    sys.exit(1)

        print("SUCCESS")
        sys.exit(0)
    except Exception as e:
        print(f"FAIL: An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_tests()

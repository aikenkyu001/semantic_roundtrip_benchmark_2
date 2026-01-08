import json

# Placeholder for the generated code
# {generated_code}

def run_tests():
    test_cases = [
        ("Hello World", "eooHll Wrld"), # Corrected: space and 'd' preserved
        ("Python", "oPythn"),
        ("aeiou", "aeiou"),
        ("bcdf", "bcdf"),
        ("AeiOu", "AeiOu"), # Corrected: 'e' removed from end
        ("", ""),
        ("123abc", "a123bc")
    ]

    results = []
    for input_str, expected_output in test_cases:
        try:
            actual_output = separate_vowels_and_consonants(input_str)
            passed = (actual_output == expected_output)
            results.append({
                "input": input_str,
                "expected": expected_output,
                "actual": actual_output,
                "passed": passed,
                "error": None
            })
        except Exception as e:
            results.append({
                "input": input_str,
                "expected": expected_output,
                "actual": None,
                "passed": False,
                "error": str(e)
            })
    
    all_passed = all(r["passed"] for r in results)
    
    if all_passed:
        print("SUCCESS")
    else:
        print("FAILURE")
        print(json.dumps(results, indent=4))

if __name__ == "__main__":
    run_tests()

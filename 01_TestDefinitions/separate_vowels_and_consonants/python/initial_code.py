def separate_vowels_and_consonants(input_string):
    """
    Separates vowels and consonants from an input string, maintaining original order.

    Args:
        input_string: The string to process.

    Returns:
        A new string with all vowels at the beginning and consonants/others at the end.
    """
    vowels = "aeiouAEIOU"
    vowel_chars = []
    consonant_chars = []

    for char in input_string:
        if char in vowels:
            vowel_chars.append(char)
        else:
            consonant_chars.append(char)
            
    return "".join(vowel_chars) + "".join(consonant_chars)


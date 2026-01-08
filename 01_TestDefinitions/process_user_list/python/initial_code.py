def process_user_list(user_data):
    """
    Processes a list of user data dictionaries to generate formatted summary strings.

    Args:
        user_data: A list of dictionaries, where each dictionary represents a user
                   with 'name' (str) and 'scores' (list of int).

    Returns:
        A list of strings, each formatted as:
        "<Name>: Average <Avg_Score> (Rank: <Rank>)"
    """
    output_list = []
    for user in user_data:
        scores = user.get('scores', [])
        name = user.get('name', 'Unknown')
        
        avg_score = 0.0
        if scores:
            avg_score = sum(scores) / len(scores)

        rank = "N/A"
        if avg_score >= 90:
            rank = "Excellent"
        elif avg_score >= 70:
            rank = "Good"
        elif avg_score > 0:
            rank = "Fair"
            
        output_str = f"{name}: Average {avg_score:.1f} (Rank: {rank})"
        output_list.append(output_str)
        
    return output_list

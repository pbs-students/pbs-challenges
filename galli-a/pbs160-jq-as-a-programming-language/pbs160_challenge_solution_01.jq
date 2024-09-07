# Search the Nobel Prizes data set as published by the Nobel Prize Committee
# by name, and with a range of years
# Input:    JSON as published by the Nobel Committee
# Output:   An array of prize dictionaries
# Variables:
#   $search:    The search string, to search in laureates names (both first name and surname)
#   $minYear    The lower year limit (inclusive) to restrict the results
#   $maxYear    The upper year limit (inclusive) to restrict the results
[
    .prizes[]
    | select((.year | tonumber) >= ($minYear | tonumber))
    | select((.year | tonumber) <= ($maxYear | tonumber))
    | select(any(.laureates[]?;
        "\(.firstname) \(.surname)"
        | ascii_downcase
        | contains($search | ascii_downcase)
    ))
]
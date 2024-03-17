# Search script to find earliest year a matching prize can have been awarded 
# Input JSON Nobel.json
# Output: array containing dictionaries of all prizes awarded on or after a given year and on or before a second-specified year
# Variables: minYear, maxYear
#
# command: jq --argjson minYear 1950 --argjson maxYear 1955 -f challenge-solution-pbs160.jq  NobelPrizes.json
#
# [
#   .prizes[]? 
#   | select((.year | tonumber >= $minYear) 
#       and ((.year | tonumber <= $maxYear)))
# ]
#
# Now to make sure there are named laureates named
# Input JSON Nobel.json
# Output: array containing dictionaries of allall prizes awarded on or after a given year and on or before another year
# Variables: minYear, maxYear, search

# command: jq --argjson minYear 1950 --argjson maxYear 1955 --arg search cecil -f challenge-solution-pbs160.jq  NobelPrizes.json
# [
#   .prizes[] 
#   | select((.year | tonumber >= $minYear) 
#       and ((.year | tonumber <= $maxYear)))
#   | select(any(.laureates[]?; 
#     "\(.firstname) \(.surname)"
#     | ascii_downcase
#     | contains($search | ascii_downcase)
#   ))
# ]

# Now for extra credit make both year arguments effectively optional
# Optional variables:
#  $ARGS.named.minYear - if unassigned then 1970
#  $ARGS.named.maxYear - if unassigned then 2000

# Command: jq --arg search bart -f challenge-solution-pbs160.jq  NobelPrizes.json
# Should not find Derek Barton in 1969 but it does

#[
#  debug ("minYear is \($ARGS.named.minYear)")
#  | debug ("maxYear is \($ARGS.named.maxYear)")
#  .prizes[] 
#  | select((.year | tonumber >= ($ARGS.named.minYear // 1901))
#      and (((.year | tonumber) <= ($ARGS.named.maxYear // 2024)))
#      )
#  | select(any(.laureates[]?; 
#    "\(.firstname) \(.surname)"
#    | ascii_downcase
#    | contains($search | ascii_downcase)
#  ))
#]

# Command: jq --arg search bart -f challenge-solution-pbs160.jq  NobelPrizes.json
#  if // is set to 1970, does NOT find Derek Barton who won in 1969 because it's less than 1970
# Command: jq --argjson minYear 1960 --arg search bart -f challenge-solution-pbs160.jq  NobelPrizes.json
# DOES find Derek Barton in 1969
# Default is // set to 1901 (first year) and 2024, current year

## Instead of defining the // years like I did, try to use the jq function `max`.
# jq '[.prizes[] | .year | tonumber] | min' NobelPrizes.json
# returns 1901
  
  | select(
    (.year | tonumber >= 
        ($ARGS.named.minYear 
        // 
        ([.prizes[] | .year | tonumber] | min) | debug("minYear is \(.)"))
      and (
    ((.year | tonumber) <= 
        ($ARGS.named.maxYear // 
        ([.prizes[] | .year | tonumber] | max) | debug("maxYear is \(.)"))))   
        )
      )
  | select(any(.laureates[]?; 
    "\(.firstname) \(.surname)"
    | ascii_downcase
    | contains($search | ascii_downcase)
  ))
]

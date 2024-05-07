# Filter HIBP to find users caught in any breach containing 
# "LinkedIn" in "Name". Note that some breaches have more in
# the filed than just LinkedIn. Filter will be case-insensitive
# Input:     JSON user data ./bart-pbs164/hibp-pbs.demo.json
#            Enrich with: JSON download from HIBP: hibp-breaches-202040329.json

# Output:    A dictionary of usernames
# Variables: $breachDetails

# transform the user data of breaches by AccountName

.Breaches | to_entries

# filter down to users caught up in LinkedIn breaches

| [
     # explode the list of entries
     .[]
     
     # select only users with "LinkedIn"
     | select(any(.value[]; . == "LinkedIn"))
     
     # filter out just the key
     # | .key
     # Successfully exports an array with just "mwkelly" inside
     
     ]
]

# run with jq -r -f jq-pbs164-challenge.jq ./bart-pbs164/hibp-pbs.demo.json
# run with jq -r -f jq-pbs164-challenge.jq --slurpfile $breachDetails hibp-breaches-202040329.json ./bart-pbs164/hibp-pbs.demo.json

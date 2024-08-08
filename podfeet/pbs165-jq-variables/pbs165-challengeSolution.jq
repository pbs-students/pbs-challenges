# Find users caught up in any breach that leaked passwords that matches a given search string.
# Input:    JSON as downloaded from the HIBP service
# Output:   An array of account names (the parts of email addresses to the left of the @).
# Variables:
# - $breachDetails	An array containing a single entry, the JSON for the
#                   latest lookup table of HIBP breaches indexed by breach
#                   name
# - $AccountName
# - $BreachName
# - $BreachTitle
# - $BreachedDataClasses

# transform the lookup of breaches by AccountName into a list of entries:
# - keys will be account names
# - values will be arrays of breach IDs

.Breaches | to_entries

# Filter for every breach for every user indexed by users email account name
| [
	# explode the list of entries
	.[]

	# save the user name for the current entry
	| .key as $AccountName
	| .value as $BreachName
	
	expand the array of breaches in the current entry into multiple reversed entries
    | .value[] | {
        key: $AccountName,
        value: $BreachName
    }
]
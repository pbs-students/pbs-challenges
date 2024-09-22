# Filter a HIBP export down to just the accounts caught up a given breach
# Input:    JSON as downloaded from the HIBP service
# Output:   The original input with the Breaches lookup table filtered down
# Variables:
# - $breach:    The name of the breach to filter by

# select only the Breaches element
.Breaches
# start by converting the lookup table to a list of entries
| to_entries
# we want the output to be an array
| [
	# explode the array of entries
	.[]
	# values is the list of breaches for each user;
	# explode it and check each element against the breach passed as input
	# convert both to lowercase to make the sarch case-insensitive
	| select(any(.value[]; . | ascii_downcase | contains($breach | ascii_downcase)))
	# extract only the key (username)
	| .key
]

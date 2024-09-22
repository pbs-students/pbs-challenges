# Filter a HIBP export down to just the accounts caught up a given breach
# Input:    JSON as downloaded from the HIBP service
# Output:   The original input with the Breaches lookup table filtered down
# Variables:
# - $breach:    The name of the breach to filter by
# - $breachDetails:	An array containing a single entry, the JSON for the
#                   latest lookup table of HIBP breaches indexed by breach
#                   name

# update the Breaches lookup table in place
.Breaches
# start by converting the lookup table to a list of entries
| to_entries
# filter the entries down to just those caught up on the breach passed as input
| [
	# explode the array of entries
	.[]
	# values is the list of breaches for each user;
	# explode it and check each element against a dictionary, which is the
	# filtered version of the $breachDetails data
	| select(any(.value[]; . | in(
			(
				# inside these grouping parentheses (possibly not needed)
				# we create the filtered version of the $breachDetails data
				#
				# we start from $breachDetails, taking only element 0, since we
				# are passing a single file
				$breachDetails[0]
				# convert the lookup to an array of entries
				| to_entries
				# we need an array to later pass it to `from_entries`, so enclose
				# in []
				| [
					# explode all the elements in the original entries
					.[]
					# select only the ones whose name (a sub-key of the `value` key)
					# matches the $breach search term; both are converted to lowercase
					# to make the comparison case-insensitive
					| select(.value.Name | ascii_downcase | contains($breach | ascii_downcase))
					# select only the ones whose DataClasses array (a sub-key of the `value` key)
					# contains "Passwords"
					| select(any(.value.DataClasses[]; . | contains("Passwords")))
				]
				# rebuild a lookup, whose keys are the names of the breaches in the original
				# $breachDetails data
				| from_entries
			)
		)))
	# extract only the key (username)
	.key
]

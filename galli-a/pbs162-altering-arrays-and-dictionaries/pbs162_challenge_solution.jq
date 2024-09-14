# creates an array of all Nobel Prize laureates, by extracting the names from the
# original file publish by the Nobel Prize Committee
# The output JSON will contain one entry per laureate (even when one laureate
# was awarded the prize multiple time), sorted by last name for people (excepting
# the two edge cases) and by first name for organizations 
# Input:	JSON as published by the Nobel Committee
# Output:	a JSON file containing only the laureates, de-duplicated and sorted

# the final result must be an array, so enclose everythin in []
[
	# we need an intermediate array for deduplication and sorting
	[
		# start by exploding the prizes array, to iterate over each prize
		.prizes[]
		# extract only the laureates key for each prize, 
		| .laureates // empty
		# explode the resulting array, to iterate over the individual laureates
		| .[]
		# add a sort_name field, containing the name starting by surname (if present)
		| .sort_name = ([(.surname // empty), .firstname] | join(" "))
		# add a displayname field, containing the name starting by first name
		| .displayname = ([.firstname, (.surname // empty)] | join(" "))
		# remove motivation and share keys, since those are particular to the prize, not to the laureate
		| del(.motivation)
		| del(.share)
	]
	# remove duplicates, and sort by sort_name
	| unique_by(.sort_name)
	# extract only the display name, from each of the 
	| .[] | .displayname
]
# format as JSON
| @json

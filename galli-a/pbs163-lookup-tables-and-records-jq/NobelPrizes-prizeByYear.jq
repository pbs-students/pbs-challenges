# creates an lookup table of all Nobel Prizes, indexed by year
# The output JSON will contain one entry per year, containing all the prizes for that year
# Input:	JSON as published by the Nobel Committee
# Output:	a JSON file containing one entry per year, containing all the prizes for that year

# extract the array of prizes from the top-level dictionary
.prizes
# group the prizes by year
| group_by(.year)
# need to have an array at the end, so enclose in square brackets
| [
	# explode the outermost array (the result of group_by, so we have one for each year)
	.[]
	# for each year, create a new dictionary
	| {
		# extract the year from the first element of the array, since all of them will be the same
		key: (.[0].year | tostring),
		# for the value, we simply explode the original entry
		value : [
			# and each element is one of the original entries
			.[]
		]
	}
  ]
# finally, convert into a lookup using the dedicated function
| from_entries
| @json

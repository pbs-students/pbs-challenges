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
		# for the value, we want to group by category
		value: group_by(.category)
		# inside of that, we want again an array, so enclose in square brackets
		| [
			# we need to explode the output of the second group_by,
			# in order to have one element for each category
			.[]
			# for each category we create a dictionary
			| {
				# for the key, we extract the category from the first element (they must all be the same)
				key: (.[0].category),
				# for the value, we want an array of elements, so again enclose in square brackets
				# there is no need to enclose everything in an array, since for each year and category,
				# there is only one prize in the original data set
				value: [
					# every element of the array is one of the original entry in the prizes
					.[]
				]
			}
		]
		# convert this second array into a lookup
		| from_entries
	}
  ]
# finally, convert into a lookup using the dedicated function
| from_entries
| @json

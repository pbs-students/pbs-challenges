# Starting with Bart's pbs161-challengeSolution.jq to create a file
# called previous.json
# Sanitise the Nobel Prizes data set as published by the Nobel Prize
# Committee to make it easier to process by normalising some existing
# fields and adding some additional ones.
# Input:    JSON as published by the Nobel Committee
# Output:   a dictionary indexed by a single key prizes containing an
#           array of dictionaries, one for each Nobel Prize
# .prizes |= [
#     # explode the prizes
#     .[]

#     # add an 'awarded' key to each prize
#     | .awarded = (has("laureates"))

#     # ensure all prizes have a laureates array
#     | .laureates //= []

#     # descend into the laureates arrays
#     | .laureates |= [
#         # explode the laureates
#         .[]

#         # add an organisation key
#         | .organisation = (has("surname") | not)

#         # add a displayName key
#         | .displayName = ([.firstname, .surname // empty] | join(" "))
#     ]
# ]

# Create an array
[
	# explode the prizes
	.prizes[]
	
	# explode the laureates 
	| .laureates[] 
	
	#select only the laureates that have surnames
	# this throws away the organization prizes
	| select(has("surname"))
] 
	# Sort the dictionaries by surname
	| sort_by(.surname)
	
	# this is one array with dictionaries so we need to explode it
	| .[] 
	
	# return only the displayName in alpha order
	| .displayName
| @json

# run adding previous.json > alpha.json

# for some reason this ends up with escaped quotes
# "\"Gerardus 't Hooft\""
# where the command not in file form does not
# "Gerardus 't Hooft"
# jq '[.prizes[] | .laureates[] | select(has("surname"))] | sort_by(.surname) | .[] | .displayName' previous.json > final.json
# Convert a HIBP export into a more useful form
# Input:    JSON as downloaded from the HIBP service
# Output:   A lookup table indexed by username, with each value being
#           a dictionary with two keys:
#           - Breaches: an array of dictionaries indexed by Name, Title, and DataClasses
#           - ExposureScore: a value indicating the overall seriousness of the breaches 
#                            the user has been exposed to
# Variables:
# - $breachDetails:	An array containing a single entry, the JSON for the
#                   latest lookup table of HIBP breaches indexed by breach
#                   name

# extract the Breaches lookup table
.Breaches
# loop over each element in the dictionary
| map_values(
	# create a dictionary with two keys; at this point, `.` is the list of
	# breaches for each user
	{
		"Breaches": . 
					# an array of dictionaries, containing
					# tha Name, Title, and DataClasses for each breach
					| map({"Name": $breachDetails[0][.].Name,
						   "Title": $breachDetails[0][.].Title,
						   "DataClasses": $breachDetails[0][.].DataClasses})
						,
		"ExposureSCore": . 
			# a single value, calculated based on the severity of the list of breaches
			# for the user; `.` is still the list of breaches, so we can pass it
			# directly to the `reduce` function
			|
			#(reduce .[] as $breach
			#	# start the accumulator at 0, and for each breach, sum the corresponding value
			#	(0; . + 
			#		# the value for each breach must be calculated inside a pair
			#		# of grouping parentheses
			#		(
			#			# since we don't have an if ... else statement
			#			# we use the alternative operator to assign either 1 or 10

			#			(
			#				(
			#					($breachDetails[0][$breach].DataClasses | contains(["Passwords"]) | not) 
			#					// empty
			#				) 
			#				| not // 1
			#			) // 10
			#		)
			#	)
			#)
			(reduce .[] as $breach
				# start the accumulator at 0, and for each breach, sum the corresponding value
				(0; . + 
					# the value for each breach must be calculated inside a pair
					# of grouping parentheses
					(
						# since we don't have an if ... else statement
						# we use the alternative operator to assign either 1 or 10
						#
						# this parenthesis will evaluate to either empty (if $breach contains passwords)
						# or 1 (if it doesn't), therefore we alternate with 10, getting 10 or 1
						(
							# this parenthesis will evaluate to either true (if $breach *does not*
							# contains passwords) or empty (if it does)
							(
								($breachDetails[0][$breach].DataClasses | contains(["Passwords"]) | not) 
								// empty
							)
							# if the output of the previous part is empty, the result of this will be
							# empty as well, since we are passing empty to a pipe.
							# So, the output of this next line will be either empty
							# (if the breach contains passwords, since it receives empty from the 
							# previous pipe), or 1 (if the breach does not contain passwords, since
							# the previous pipe outputs true, which we negate, and the alternative
							# operator selects the 1)
							| not // 1
						# here we are receiving either empty (if the breach contains passwords)
						# or 1 (if it doesn't), but unlike in the line above, we are *not*
						# passing the result to a pipe. Therefore, in this case empty counts
						# as a falsy value, so in that case the alternative operator outputs
						# what is on its right side, i.e. 10. In the other case, 1 is truthy,
						# so it is passed unaltered
						) // 10 
					)
				)
			)
	}
)
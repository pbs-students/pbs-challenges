#!/usr/bin/env bash

# Exit codes:
# 1: missing required args or unsupported flags or optional args
# 2: invalid value for supported arg

# store the usage string
usage="Usage: $(basename $0) [-s START_VALUE] [-e END_VALUE] -- base_number"

# initialize default limits
start_multiplier=1
end_multiplier=10

# accept an optional number (using m) to impose a lower value and
# another optional numner (using M) to inmpose an upper value
# save the name of the matched option in $opt (our choice of name)
while getopts ':s:e:-' opt
do
    case $opt in
        s)
            # store the start multiplier
			if [[ -n "$OPTARG" ]]
			then
				# validate that the argument is a valid number
				if echo "$OPTARG" | egrep -q '^-?[1-9][[:digit:]]*$'
				then
					start_multiplier="$OPTARG"
				else
					echo "invalid argument '$OPTARG' - must be an integer number"  > /dev/tty
					exit 2
				fi
			fi
            ;;
        e)
			# store the upper value
			if [[ -n "$OPTARG" ]]
			then
				# validate that the argument is a valid number
				if echo "$OPTARG" | egrep -q '^-?[1-9][[:digit:]]*$'
				then
					end_multiplier="$OPTARG"
				else
					echo "invalid argument '$OPTARG' - must be an integer number"  > /dev/tty
					exit 2
				fi
			fi
            ;;
        -)
			# stops reading options, pass the rest as arguments
			break
			;;
        ?)
            # render a sane error, then exit
            echo "$usage"  > /dev/tty
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

# deal with reading inputs, with both first argument or piped argument
if [[ -t 0 ]]
then
	# we are reading from terminal, so use first argument
    base_number="$1"
else
	# we are reading from pipe, so slurp it
    base_number=$(cat)
fi

# use the first arg as the value for the base number
if [[ -n "$base_number" ]]
then
	# validate that the argument is a valid number
	if echo "$base_number" | egrep -q '^-?[1-9][[:digit:]]*$'
	then
		base_number="$base_number"
	else
		echo "invalid argument '$base_number' - must be an integer number"  > /dev/tty
		exit 2
	fi
else
	echo "$usage"  > /dev/tty
	exit 1
fi

# count the number of digits in base_number
base_number_length=$(printf "%'d" $base_number | wc -m | xargs)

# count the number of digits in multiplier, taking the largest
start_multiplier_length=$(printf "%'d" $start_multiplier | wc -m | xargs)
end_multiplier_length=$(printf "%'d" $end_multiplier | wc -m | xargs)

multiplier_length=$(( start_multiplier_length >= end_multiplier_length ? start_multiplier_length : end_multiplier_length ))

# count the maximum number of digints in result

# calculate the results for the two extreme multipliers.
# the maximum value must be one of those two
start_result=$(( base_number * start_multiplier ))
end_result=$(( base_number * end_multiplier ))

# find the number of characters for the two results just calculated
start_result_length=$(printf "%'d" $start_result | wc -m | xargs)
end_result_length=$(printf "%'d" $end_result | wc -m | xargs)

result_length=$(( start_result_length >= end_result_length ? start_result_length : end_result_length ))

# define the format string for each row
format_string="%'$base_number_length""d x %'$multiplier_length""d = %'$result_length""d\n"

# initialize empty variable to hold resulting table
output_string=''
# create loop to print table
for i in $(seq $start_multiplier $end_multiplier)
do
	# calculate the result for the current multiplication
	result=$(( base_number * i ))
	# create the row string, using the format string defined above
	printf -v row_string "$format_string" $base_number $i $result
	# append the row string to the output string
	output_string+="$row_string"
done

# check number of lines in output
if [[ -t 1 ]]
then
	# if STDOUT is terminal, pipe to pager
	# --no-init keeps result on screen when pager quit
	# --quit-if-one-screen immediately exit pager for few lines
	printf "%s" "$output_string" | less --quit-if-one-screen --no-init
else
	# if we are redirecting, print directly
	printf "%s" "$output_string"
fi

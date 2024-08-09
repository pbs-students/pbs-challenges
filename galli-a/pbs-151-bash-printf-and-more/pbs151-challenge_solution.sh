#!/usr/bin/env bash

# store the usage string
usage="Usage: $(basename $0) [-m LOWER_VALUE] [-M UPPER_VALUE] base_number"

# define limit to switch to pager if number of lines
# in output is larger than the limit, and only if
# we are writing directly to STDOUT
MAX_LINES_NO_PAGER=10

# initialize default limits
first_limit=1
second_limit=10

# accept an optional number (using m) to impose a lower value and
# another optional numner (using M) to inmpose an upper value
# save the name of the matched option in $opt (our choice of name)
while getopts ':m:M:' opt
do
    case $opt in
        m)
            # store the lower value
            # echo "DEBUG saving lower value '$OPTARG'"  > /dev/tty
			if [[ -n "$OPTARG" ]]
			then
				# validate that the argument is a valid number
				if echo "$OPTARG" | egrep -q '^-?[1-9][[:digit:]]*$'
				then
					first_limit="$OPTARG"
				else
					echo "invalid argument '$OPTARG' - must be an integer number"  > /dev/tty
					exit 2
				fi
			fi
            ;;
        M)
			# store the upper value
            # echo "DEBUG saving upper value '$OPTARG'"  > /dev/tty
			if [[ -n "$OPTARG" ]]
			then
				# validate that the argument is a valid number
				if echo "$OPTARG" | egrep -q '^-?[1-9][[:digit:]]*$'
				then
					second_limit="$OPTARG"
				else
					echo "invalid argument '$OPTARG' - must be an integer number"  > /dev/tty
					exit 2
				fi
			fi
            ;;
        ?)
            # render a sane error, then exit
            echo "$usage"  > /dev/tty
            exit 1
            ;;
    esac
done
shift $(echo "$OPTIND-1" | bc)

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
	if echo "$base_number" | egrep -q '^[1-9][[:digit:]]*$'
	then
		base_number="$base_number"
	else
		echo "invalid argument '$base_number' - must be an integer positive number"  > /dev/tty
		exit 2
	fi
else
	echo "$usage"  > /dev/tty
	exit 1
fi

# count the number of digits in base_number
base_number_length=$(printf "%'d" $base_number | wc -c | xargs)

# count the number of digits in multiplier, taking the largest
first_limit_length=$(printf "%'d" $first_limit | wc -c | xargs)
second_limit_length=$(printf "%'d" $second_limit | wc -c | xargs)

if [[ first_limit_length -ge second_limit_length ]]
then
	multiplier_length=$first_limit_length
else
	multiplier_length=$second_limit_length
fi

# count the maximum number of digints in result

# calculate the results for the two extreme multipliers.
# the maximum value must be one of those two
first_limit_result=$(bc <<< "$base_number * $first_limit")
second_limit_result=$(bc <<< "$base_number * $second_limit")

# find the number of characters for the two results just calculated
first_limit_result_length=$(printf "%'d" $first_limit_result | wc -c | xargs)
second_limit_result_length=$(printf "%'d" $second_limit_result | wc -c | xargs)

if [[ first_limit_result_length -ge second_limit_result_length ]]
then
	result_length=$first_limit_result_length
else
	result_length=$second_limit_result_length
fi

# define the format string for each row
format_string="%'$base_number_length""d x %'$multiplier_length""d = %'$result_length""d\n"

# initialize empty variable to hold resulting table
output_string=''
# create loop to print table
for i in $(seq $first_limit $second_limit)
do
	# calculate the result for the current multiplication
	result=$(bc <<< "$base_number * $i")
	# create the row string, using the format string defined above
	# add an additional word at the end of each row to avoid the shell expansion
	# to remove the newline at the end
	row_string=$(printf "$format_string" $base_number $i $result; printf "extra")
	# append the row string to the output string, removing the additional word at the end
	output_string+="${row_string%extra}"
done

# check number of lines in output
num_output_lines=$(printf "%s" "$output_string" | wc -l | xargs)
if [[ $num_output_lines -gt $MAX_LINES_NO_PAGER ]] && [[ -t 1 ]]
then
	# for output longer than limit, pipe to pager
	printf "%s" "$output_string" | less
else
	# for shorter output, or if we are not redirecting, print directly
	printf "%s" "$output_string"
fi

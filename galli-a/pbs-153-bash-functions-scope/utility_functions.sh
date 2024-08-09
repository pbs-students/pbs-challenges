# define a function to validate an integer number (either positive or negative)
# Arguments : the value to test
# Flags     : 
# STDIN     : the value to test
# STDOUT    : the input value, if valid
# Return codes:
# 	0 - the value is valid
#	1 - the value is not valid
is_integer_number () {
	# localize variables
	local value integer_regex

	# define the regex used to validate integer values
	integer_regex='^-?[[:digit:]]+$'

	# check if there are any inputs; if so assign directly to value,
	# otherwise slurp from STDIN
	if [[ $# -gt 0 ]]
	then
		value="$1"
	else
		value=$(cat)
	fi
	# now check if $value is valid
	if echo "$value" | egrep -q "$integer_regex"
	then
		return 0
	else
		return 1
	fi
}

# define a function to validate a number (either positive or negative, with or without a decimal part)
# Arguments : the value to test
# Flags     : 
# STDIN     : the value to test
# STDOUT    : the input value, if valid
# Return codes:
# 	0 - the value is valid
#	1 - the value is not valid
is_number () {
	# localize variables
	local value integer_regex

	# define the regex used to validate integer values
	number_regex='^-?[[:digit:]]+(.[[:digit:]]+)?$'

	# check if there are any inputs; if so assign directly to value,
	# otherwise slurp from STDIN
	if [[ $# -gt 0 ]]
	then
		value="$1"
	else
		value=$(cat)
	fi
	# now check if $value is valid
	if echo "$value" | egrep -q "$number_regex"
	then
		return 0
	else
		return 1
	fi
}

# Arguments : 1 .. n the values to test
# Flags     : -w
# STDIN     : 1 .. n the values to test
# STDOUT    : the maximum value among the arguments
# Return codes:
#
# if passed -w, writes to terminal a warning message for any input that is not a number
find_max() {
	# localize variables
	local input number max enable_warning opt OPTIND OPTARG

	# process the optional arguments
    enable_warning=''
    while getopts ':w' opt
    do
        case $opt in
            w)
                # save the fact that any int is OK
                enable_warning=1
                ;;
            ?)
                # render a sane error, then return
                echo 'Function Usage: find_max [-w] [VALUES ...]'
                return 1
                ;;
        esac
    done

    # remove the optional args from the argument list
    shift $(( OPTIND - 1 ))

	# check if there are any inputs; if so use them,
	# otherwise slurp from STDIN
	if [[ $# = 0 ]]
	then
		input=($(cat))
	else
		input=("$@")
	fi
	
	# loop thrugh the input
	max="${input[0]}"
	for number in "${input[@]}"
	do
		if ! is_number "$number"
		then
			if [[ -n $enable_warning ]]
			then
				echo "$number is not a number" > /dev/tty
			fi
			continue
		fi
		if (( number > max ))
		then
			max="$number"
		fi
	done

	echo "$max"
}
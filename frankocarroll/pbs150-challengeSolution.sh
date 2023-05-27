#!/usr/bin/env bash

# initialise the options to their default values
limit='' # no limit
snark='' # no snark # snark removed from this version
menuFile="./menu.txt" # default menu file in current directory
# menuFile="$(dirname "$BASH_SOURCE")/menu.txt"

# Process the commandline options
# All error and progress messages enclosed by the loop
# are redirected to stderr at the end of the loop

while getopts 'l:m:' opt
do
    case $opt in
        l)
            # validate and store the limit
            if echo "$OPTARG" | egrep -q '^[1-9][0-9]*$'
            then
                limit=$OPTARG
            else
                echo "Error: $(basename $0):invalid limit - must be an integer greater than zero"
                exit 2;
            fi
            ;;
        m)
	    # Check for special case
	    # We make use of the convenient special file /dev/stdin
	    if [[ "$OPTARG" == '-' ]]
	    then
		OPTARG='/dev/stdin'
	    fi
            if [[ -r "$OPTARG" ]]
	    then
                menuFile="$OPTARG"
	    else
                echo "Error: $(basename $0): can't read menu file"
                exit 3
	    fi
            ;;
        ?)
            echo "Usage: $(basename $0) [-l LIMIT] [-m FILE | - ]"
            exit 2
            ;;
    esac
# Finish option arguments and redirect all option parse errors to stderr
done 1>&2

# At this point menuFile is either the default, or the name of a readable
# menu file from the command line, or /dev/stdin
# Read the menu by redirecting stdin from $menuFile at end of loop
declare -a menu
while read -r menuLine
do
    # skip comment lines
    echo "$menuLine" | egrep -q '^[ ]*#' && continue

    # skip empty lines
    echo "$menuLine" | egrep -q '^[ ]*$' && continue

    # store the menu item
    menu+=("$menuLine")
done <"$menuFile"

# create an empty array to hold the order
declare -a order

# THE BIG INPUT/OUTPUT SWITCHEROO
# ~~~~~~~~~~~~~~~~~~~~~~~~
# At this point, we have the menu in the menu array
# If we read the menu from stdin, then we should use /dev/tty for 
# selecting the menu items.
# If we did not read the array from stdin (default or -m FILE)
# then we need to read the keyboard input from /dev/stdin because
# we need to support the use cases where you pipe a favorite selection list
# to the select loop
# 	cat favoriteChoices.txt | command 
# 	cat favoriteChoices.txt | command -m menufile
# as well as the interactive use case
# Redirect all output to /dev/tty
# Redirect all input from either stdin or /dev/tty

if [[ "$menuFile" == "/dev/stdin" ]]
then
	INPUT=/dev/tty
else
	INPUT=/dev/stdin
fi

# We group all the following commands in a { braced group }
# like so { command; command; command ... ; } < input > output
# so that we can redirect the input and output of all the commands
# from the right devices, depending on use case.
# the { ... } does NOT do a subshell but uses the current shell
{
	# present the menu, with a done option
	if [[ -z $limit ]]
	then
		echo 'Choose your breakfast (as many items as you like)'
	else
		echo "Choose up to $limit breakfast items"
	fi
	select item in done "${menu[@]}"
	do
	    # skip invalid selections ($item is empty)
	    [[ -z $item ]] && continue

	    # exit if done
	    [[ $item == done ]] && break

	    # store and print the item
	    order+=("$item")
	    echo "Added $item to your order"

	    # if we're limiting, check the limit
	    if [[ -n $limit ]]
	    then
		[[ ${#order[@]} -ge $limit ]] && break
	    fi
	done
} >/dev/tty <$INPUT

# print the order
echo -e "\nYou ordered the following ${#order[@]} items:"
for item in "${order[@]}"
do
    echo "* $item"
done

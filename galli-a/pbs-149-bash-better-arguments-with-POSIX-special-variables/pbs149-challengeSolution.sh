#!/usr/bin/env bash

# initialize variable defining optional behavior
snark_enabled='' # assume -s is not passed
item_limit='' # default to empty to not have a maximum limit

# store the usage string
usage="Usage: $(basename $0) [-s] [-l LIMIT]"

# accept a flag named s to request snark, and an optional
# number l to impose a limit
# save the name of the matched option in $opt (our choice of name)
while getopts ':sl:' opt
do
    case $opt in
        s)
            # store the snarky / not snarky selection
            snark_enabled=1
            ;;
        l)
            # store the limit
            item_limit="$OPTARG"
			# initialize to empty string
			if [[ -n "$OPTARG" ]]
			then
				# validate that the argument is a valid number
				if echo "$OPTARG" | egrep -q '^[1-9][[:digit:]]*$'
				then
					item_limit="$OPTARG"
				else
					echo "invalid argument '$OPTARG' - must be an integer positive number"  > /dev/tty
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

# read from the breakfast_menu.txt file, to load
# items to be inserted in the menu
# items are listed one per line, and there can be empty
# lines and comments, which will be ignored

# filename containing the menu items
menu_filename="$(dirname "$BASH_SOURCE")/breakfast_menu.txt"

# create empty array to hold the menu
declare -a menu
while read -r line
do
	# skip empty lines
	if [[ -z $line ]]
	then
		continue
	fi

	# skip comments, i.e. lines that begin with a `#`,
	# even if it is not the first character in the line
	if echo "$line" | egrep -q "^\s*#"
	then
		continue
	fi

	# if we arrive here, the line is valid,
	# so append it to the menu
	menu+=("$line")
	# echo $menu
done < <(cat $menu_filename)

# modify the menu to include an additional item to complete the order
menu+=("enough thanks")

# declare an empty array to contain all the items selected by the user
declare -a user_order

menu_selection_message=''

if [[ -n $snark_enabled ]]
then
	menu_selection_message+='Hey!'
else
	menu_selection_message+='Hello,'
fi

if [[ -z $item_limit ]]
then
	menu_selection_message+=" select your menu:"
else
	menu_selection_message+=" select up to $item_limit items for your menu:"
fi
echo "$menu_selection_message"

select item in "${menu[@]}"
do
	# skip invalid selections ($item is empty)
	[[ -z $item ]] && continue

	# exit when done
    [[ $item == 'enough thanks' ]] && break

    # valid item, add to the order
    user_order+=($item)

    # check the number of selected items against the limit, if set
    if [[ -n $item_limit ]]
    then
    	[[ ${#user_order[@]} -ge $item_limit ]] && break
    fi
done

# print back the order
echo -e "\nYour order contains:"
for item in "${user_order[@]}"
do
	echo "* $item"
done
#!/usr/bin/env bash

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

# use first optional argument as maximum number of items
# initialize to empty string
item_limit=''
if [[ -n $1 ]]
then
	# validate that the first argument is a valid number
	if echo "$1" | egrep -q '^[1-9][[:digit:]]*$'
	then
		item_limit=$1
	else
		echo "invalid argument '$1' - must be an integer positive number"
		exit 2
	fi
fi

if [[ -z $item_limit ]]
then
	echo "Select your menu:"
else
	echo "Select up to $item_limit items for your menu:"
fi
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
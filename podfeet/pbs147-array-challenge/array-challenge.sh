#!/usr/bin/env bash

# Written by Allison Sheridan (aka @podfeet) in 2023 under the MIT license
# This script was written as a response to the challenge posted by
# Bart Busschots in Programming By Stealth 146 at https://pbs.bartificer.net/pbs147
# The challenge was written as:
# Write a script to take the user’s breakfast order.

# The script should store the menu items in an array, then use a select loop to present the user with the menu, plus an extra option to indicate they’re done ordering. 
# Each time the user selects an item, append it to an array representing their order. 
# When the user is done adding items, print their order.
# For bonus credit, update your script to load the menu into an array from a text file containing one menu item per line, ignoring empty lines and lines starting with a # symbol.

# Create an array of breakfast foods
declare -a breakfastMenu
# Create an array to hold the user's order
declare -a order

# NOTE Tried to save default value of IFS to a variable and set it back afterwards but that broke up "more bacon" again into two strings
# SAVEIFS=$IFS
# Set IFS to anything BUT space, so that More Bacon is one entry in the resulting array
# IFS="/"

# Loop through the menu.txt file and populate the breakfastMenu array

while read -r line
  do
    # skip invalid selections ($food is empty)
    [[ -z $line ]] && continue
    
    # skip comment lines
    echo "$line" | egrep -q '^[ ]*#' && continue

    breakfastMenu+=("$line")

  # cat to read in the file
  # $BASH_SOURCE if the path of the executing script including script name
  # dirname grabs just the directory name from $BASH_SOURCE
  # menu.txt is where our breakfast menu resides
  done <<< "$(cat $(dirname "$BASH_SOURCE")/menu.txt)"
  echo ${breakfastMenu[6]} # expected value: more bacon 

# IFS=$IFS


# Allison's challenge - let the user add to the menu
# Bart explained we don't know what they typed - if they type anything but one of the numbers, it returns an empty string
# He said you could note if an empty string was received
# And respond by asking if they meant to ask for something on the menu and then record it and THEN append to the menu

# Create a user prompt
# Include the available menu items from the array
# Bart suggested a number is how they can choose "I'll have a number 7"
# look at Select Menu Loops in [pbs.bartificer.net/...](https://pbs.bartificer.net/pbs146)

echo -e "Let me read you the breakfast menu.
Type the number for the item you would like.
When you're done ordering, type 1 to select done"

select food in ${breakfastMenu[@]}
# select item in done "${menu[@]}"
do 
  # skip invalid selections ($food is empty)  
  [[ -z $food ]] && continue

  # exit if done
  [[ $food == done ]] && break

  order+=("$food")
  echo "You added $food to your order"
  
done

echo "Let me read your order back to you:"
for item in ${order[@]}
  do
    echo "* $item"
  done

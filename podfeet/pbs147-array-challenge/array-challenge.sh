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
IFS="/"

# BUG: if I leave it waiting too long to answer, I get the error ./array-challenge.sh: line 96: xt: command not found. And weirder yet, sometimes "xt" is ".txt". One time it just said "t"
# Loop through the menu.txt file and populate the breakfastMenu array
i=0
while read line
  # if line contains space, replace with "\ " when added to bM

  do breakfastMenu[$i]="$line"
    i=$((i+1))
  done < menu.txt

# DID NOT WORK - Tried to set default IFS to a variable and then Restore IFS to default afterwards
# IFS=$SAVEIFS

# Create a user prompt
# Include the available menu items from the array
# Bart suggested a number is how they can choose "I'll have a number 7"
# look at Select Menu Loops in [pbs.bartificer.net/...](https://pbs.bartificer.net/pbs146)

echo -e "Let me read you the breakfast menu.
Type the number for the item you would like.
When you're done ordering, type the number that corresponds to \"done\""
select food in ${breakfastMenu[@]}
  do
    if [[ $food == 'Done' ]]
    then
      echo "Thank you. Your order is:"
      for item in ${order[@]}
        do
          echo "* $item"
        done
      break
    fi
    # got this syntax from https://www.masteringunixshell.net/qa36/bash-how-to-add-to-array.html to keep spaces between the elements
    order+=("$food")
    echo "Your order so far contains:"
    for item in ${order[@]}
      do
        # echo "there are ${#order[@]} items in your order"
        # this lists each item but not as individual lines
        # echo "Your order so far is: * $item". Can I get you anything else?"
        # this only gives me the FIRST item. why?
        echo "* $item"
      done
   
  done

# Maybe they can have more than one of something - will require counting...

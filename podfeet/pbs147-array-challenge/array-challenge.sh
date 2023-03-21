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

# DID NOT WORK - Tried to save default value of IFS to a variable and set it back afterwards but that broke up "more bacon" again into two strings
# SAVEIFS=$IFS
# Set IFS to anything BUT space, so that More Bacon is one entry in the resulting array
IFS="/"

# Loop through the menu.txt file and populate the breakfastMenu array
i=0
while read line
  # if line contains space, replace with "\ " when added to bM
  
  do breakfastMenu[$i]="$line"
    i=$((i+1))
  done < menu.txt

# DID NOT WORK - Restore IFS to default
# IFS=$SAVEIFS

# Create a user prompt
# Include the available menu items from the array
# Bart suggested a number is how they can choose "I'll have a number 7"
# look at Select Menu Loops in [pbs.bartificer.net/...](https://pbs.bartificer.net/pbs146)
# 
# this is giving a numbered list but it's seeing more and bacon as two items
# put quotes back into menu.txt but it's still two things in the prompt
# tried changing it to More\ Bacon and "More Bacon" but it still split it
select food in ${breakfastMenu[@]}
  do
    if [[ $food == 'Done' ]]
    then
      break
    fi
    echo "Have some $food"
  done

# Maybe they can have more than one of something - will require counting...



#
# things that didn't work
#

# cat menu.txt | while read -r item
#   do
#     # echo "item is $item"
#     # Add each item with a space after it to the array breakfastMenu
#     breakfastMenu+="$item "
#     echo "breakfastMenu: ${breakfastMenu[@]}"
#     # This should show 8 items but it says 1
#     echo "There are ${#breakfastMenu[@]} items in the breakfast menu"
    
#   done
#   # this should show all of the items in the array separated by spaces but nothing comes out
#     echo "breakfastMenu: ${breakfastMenu[@]}"
#     # this SHOULD tell me the fourth element in the array when it exists but it doesn't
#     echo "${breakfastMenu[3]}"


# breakfastMenu=
#     while read item
#       do echo $item | $breakfastMenu
#         echo $breakfastMenu
#       done < menu.txt
  
# while IFS= read -r item
#   do breakfastMenu+=("$item")
#   echo $breakfastMenu
#   done < menu.txt

# loop through menu in text file
# This works to simply echo out the lines from menu.txt
# while read item
#   do echo $item
#   done < menu.txt

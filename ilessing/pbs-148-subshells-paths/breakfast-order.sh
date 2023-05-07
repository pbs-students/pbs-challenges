#!/usr/bin/env bash

# usage: takes your breakfast order.  
# Uses a set of menu items stored in a text file
# breakfast-order.sh [number of items to order]


declare -a mymenu
declare -a myorder

# read menu items from stored menu.txt file
# skip blank lines and comment lines in the menu.text file
while IFS= read
  do
    [[ -z $REPLY ]] && continue
    [[ $REPLY =~ ^[\#] ]] && continue #not sure how/why this works. I don't understand the syntax.
    mymenu+=("$REPLY")
  done < menu.txt 

# if no argument is passed, default to number of items in the menu
# otherwise, use the argument passed to the script
if [[ -z $1 ]] 
then
  numitems=${#mymenu[@]}
# $1 is numeric and less than or equal to the number of items in the menu
elif [[ $1 =~ ^[0-9]+$ ]] && [[ $1 -le ${#mymenu[@]} ]]
  then
    numitems=$1
  else
  # user entered too high a number or a non-number
  echo "out of range. Now, let's be reasonable.  I'll give you the whole menu"
  numitems=${#mymenu[@]}
fi

echo "you can choose up to $numitems items from the menu"


# push one more item to the end of the array
mymenu+=(done)

# echo "${mymenu[5]}"; exit; # expected value: "wheat toast"

# show count of menu items
echo "there are ${#mymenu[@]} menu items available"

# prompt text for the user
# PS3 is the prompt used by `select`
PS3="select your breakfast: "

# a select loop over the array
select itemchosen in "${mymenu[@]}"
  do 

    # test if they are done or not
    if [[ $itemchosen != done ]]
    then
      # test if they have chosen something from the menu
      if [[ -z $itemchosen ]]
        then
          echo "sorry bud.  that's not on the menu"
        else
          # user made a valid menu selection so lets record their choice
          # by adding their choice to an array
          echo -e "\n you want $itemchosen."
          myorder+=("$itemchosen")

          # here we test if they have reached the limit specified by command line argument
          [[ ${#myorder[@]} -eq $numitems ]]  && break
   
        fi
    else
    # double square brackets to test if user entered "done".  
    # the break executes only if the expression in the square brackets resolves true
    [[ $itemchosen == done ]]  && break

    fi
  done

echo -e "\n\n you ordered: ${myorder[@]} \n\n I'm sending it to the kitchen now."

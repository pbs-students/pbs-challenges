#!/usr/bin/env bash

# usage: 

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
      echo -e "\n you want $itemchosen.  Okay"
      myorder+=("$itemchosen")
    fi

else

  # double square brackets to test if user entered "done".  
  # the break executes only if the expression in the square brackets resolves true
  [[ $itemchosen == done ]] && break
  fi
done

echo -e "\n you ordered: ${myorder[@]}"

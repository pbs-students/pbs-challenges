#!/usr/bin/env bash

# usage: 

declare -a mymenu
declare -a myorder

# add items to the array
mymenu=("eggs" "oatmeal" "croisant" "waffles" "toast" "yogurt" "fruit")

# push one more item to the end of the array
mymenu+=(done)

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

echo "you ordered: ${myorder[@]}"

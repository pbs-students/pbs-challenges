#!/usr/bin/env bash

# usage: 

declare -a mymenu

# add items to the array
mymenu=("eggs" "oatmeal" "croisant" "waffles" "toast" "yogurt")

# push one more item to the end of the array
mymenu+=(fruit)

# show count of menu items
echo "there are ${#mymenu[@]} menu items available"

# promt text for the user
PS3="select your breakfast: "

# a select loop over the array
select itemchosen in "${mymenu[@]}"
do 
  echo -e "\n you want $itemchosen.  Okay"
  break
done
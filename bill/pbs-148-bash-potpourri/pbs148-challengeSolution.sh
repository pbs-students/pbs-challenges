#!/usr/bin/env bash

echo "Welcome to The Gluten Free Zone"
read -p "Which meal are you here for today; [b]reakfast, [l]unch or [d]inner " meal
read -p "And how many items will you want to eat today? " num_o_items

shortmeal=${meal::1}
case $shortmeal in
    b)
        menu_name="breakfast_menu.txt"
        ;;
        
    l)
        menu_name="lunch_menu.txt"
        ;;
    d)
        menu_name="dinner_menu.txt"
        ;;
    *)
        echo "Please enter [b]reakfast, [l]unch, or [d]inner, try again."
        exit 1
        ;;
esac

re='^[0-9]+$'
if ! [[ $num_o_items =~ $re ]] ; then
   echo "Apparently you only want one thing"
   num_o_items=1
fi

this_dir=$PWD"/"

if [[ $this_dir == *"/bill/pbs-148-bash-potpourri/" ]]
then
    lib_dir="../lib"
    menu_file=$this_dir$menu_name
elif [[ $this_dir == *"/bill/" ]]
then
    lib_dir="lib"
    menu_file=$this_dir"pbs-148-bash-potpourri/"$menu_name
else 
  echo "You must run this script in bill's directory for the challenge."
  exit 1
fi

if [[ ! -e $menu_file ]]
then 
  echo $menu_file
  exit 2
fi
source $lib_dir"/getArray.sh"
source $lib_dir"/inArray.sh"

echo ""
echo "Here is today's Totally Gluten-free Menu"
getArray "$menu_file"
for i in ${a_array[@]}
do
    if [[ ! $i == "#"* ]]
    then
        echo "$i"
    fi
done

order=()

loopi=1

while [[ $loopi -le $num_o_items ]]
do
    read -p "For item $loopi what do you want? " this_item
    inArray $this_item "${a_array[@]}"
    if [[ $is_yes = "Yes" ]]
    then
      order+=("$this_item")
      ((loopi++))
    else
      echo "That is not on the menu, but I can look into adding it at a latter time."
    fi
    
done

echo "I have as your order" ${order[@]}
echo ""
for i in ${order[@]}
do
    echo "$i"
done
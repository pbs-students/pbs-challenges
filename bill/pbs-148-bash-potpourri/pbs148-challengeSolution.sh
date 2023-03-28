#!/usr/bin/env bash
echo "Welcome to The Gluten Free Zone\n"
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

if [[ $this_dir == *"/bill/pbs-148-bash-potpourri"* ]]
then
    menu_file=$this_dir$menu_name
elif [[ $this_dir == *"/bill"* ]]
then
    menu_file=$this_dir"pbs-148-bash-potpourri/"$menu_name
else 
  echo "You must run this script in bill's director for the challenge."
  exit 1
fi

if [[ ! -e $menu_file ]]
then 
  echo $menu_file
  exit 2
fi

echo "\nHere is today's Totally Gluten-free Menu"

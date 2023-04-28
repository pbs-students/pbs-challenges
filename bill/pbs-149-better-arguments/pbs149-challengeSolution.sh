#!/usr/bin/env bash

is_snarky="no"
num_o_items=20
meal="b"
short_meal="b"
solution_dir="pbs-149-better-arguments"

while getopts ":sl:m:" opt; do
    case $opt in
        s)
            is_snarky="yes"
            ;;
        l)
            num_o_items=$OPTARG
            if [[ $num_o_items -lt 1 ]] || [[ $num_o_items -gt 20 ]]
            then
                echo "Please enter a value between 1 and 20 when specifying a limit to the number of items you are ordering."
                exit 1            
            fi
            ;;
        m)
            meal=$OPTARG
            test_meal=${meal::1}
            if [[ $test_meal != "b" ]] && [[ $test_meal != "l" ]] && [[ $test_meal != "d" ]]
            then
                echo "Please enter [b]reakfast, [l]unch, [d]inner" >&2
                exit 1
            else
                short_meal=$test_meal
            fi
            ;;
        \?)
            echo "Valid options are:" >&2
            echo "  -s - snarky output" >&2
            echo "  -l x -
             limit number of items to x amount, max of 20" >&2
            echo "  -m y - which meal you want: [b]reakfast, [l]unch, [d]inner" >&2
            exit 1
            ;;
    esac
done

echo "Snarky: "$is_snarky
echo "meal: "$short_meal
echo "limit: "$num_o_items

if [[ $short_meal != "b" ]] && [[ $short_meal != "l" ]] && [[ $short_meal != "d" ]]
then
    if [[ $is_snarky = "no" ]]
    then
        echo "Welcome to The Gluten Free Zone"
        read -p "Which meal are you here for today; [b]reakfast, [l]unch or [d]inner " meal
    else
        echo "Heya hun, don't go dragging any gluten in here, we are The Gluten Free Zone"
        read -p "Don't want breakfast? Spill, what you want. [b]reakfast, [l]unch or [d]inner " meal
    fi
    short_meal=${meal::1}
fi

case $short_meal in
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

this_dir=$PWD"/"

if [[ $this_dir == *"/bill/"$solution_dir"/" ]]
then
    lib_dir="../lib"
    menu_file=$this_dir$menu_name
elif [[ $this_dir == *"/bill/" ]]
then
    lib_dir="lib"
    menu_file=$this_dir$solution_dir"/"$menu_name
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
echo "Here is today's Totally Gluten-Free Menu"
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
    if [[ $is_snarky = "no" ]]
    then
        read -p "For item $loopi what do you want? " this_item
    else
        read -p "Let's get on with it, what do you want? This will be item $loopi. " this_item
    fi
    inArray $this_item "${a_array[@]}"
    if [[ $is_yes = "Yes" ]]
    then
      order+=("$this_item")
      ((loopi++))
    else
        if [[ $is_snarky = "no" ]]
        then
            echo "That is not on the menu, but I can look into adding it at a latter time."
        else
            echo "Hun, do you know how to read, it's not on the menu? Try again."
        fi
    fi
    
done

if [[ $is_snarky = "n" ]]
then  
    echo "I have as your order:" ${order[@]}
else
    echo "Here's what you are getting, like it or not:" ${order[@]}
fi
echo ""

# for i in ${order[@]}
# do
#     echo "$i"
# done


#!/usr/bin/env bash

is_snarky="no"
num_o_items=0
meal=""
short_meal=""
solution_dir="pbs-149-better-arguments"
menu_dir=""

while getopts ":sl:m:-:" opt; do
    case $opt in
      -)
        given_meal=""
        given_items=""
        case "${OPTARG}" in
           snarky)
             is_snarky="yes"
             ;;
           meal)
             given_meal="${!OPTIND}"; OPTIND=$(( $OPTIND + 1))
             ;;
           meal=*)
             given_meal=${OPTARG#*=}
             ;;
           items)
             given_items="${!OPTIND}"; OPTIND=$(( $OPTIND + 1))
             ;;
           items=*)
             given_items=${OPTARG#*=}
             ;;
           \?)
             echo "--"${OPTARG}" is not an option, moving on."
             ;;
        esac
        test_meal=${given_meal::1}
        if [ $test_meal != "b" ] && [ $test_meal != "l" ] && [ $test_meal != "d" ]
        then
          echo "Please enter [b]reakfast, [l]unch, [d]inner" >&2
          exit 1
        else
          short_meal=$test_meal
        fi
        if [ $given_items -gt 0 ] && [ $given_items -lt 21 ]
        then
         num_o_items=$given_items
        else
          echo "The number of items has to be between 1 and 20. You are getting 10"
          num_o_items=10
        fi
        ;;
      s)
        is_snarky="yes"
        ;;
      l)
        num_o_items=$OPTARG
        if [ $num_o_items -lt 1 ] || [ $num_o_items -gt 20 ]
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
        echo "  -s or --snarky - snarky output" >&2
        echo "  -l x  or --limit=x -
          limit number of items to x amount, max of 20" >&2
        echo "  -m y or --meal=y - which meal y you want: [b]reakfast, [l]unch, [d]inner" >&2
        exit 1
        ;;
    esac
done

if [[ $short_meal != "b" && $short_meal != "l" && $short_meal != "d" ]]
then
    if [[ $is_snarky = "no" ]]
    then
        echo "Welcome to The Gluten Free Zone"
        read -p "Which meal are you here for today; [b]reakfast, [l]unch or [d]inner " meal
    else
        echo "Heya hun, don't go dragging any gluten in here, we are The Gluten Free Zone"
        read -p "Confused about what to eat? Spill, what you want. [b]reakfast, [l]unch or [d]inner " meal
    fi
    short_meal=${meal::1}
fi

if [ $num_o_items -lt 1 ] || [ $num_o_items -gt 20 ]
then
    if [[ $is_snarky = "no" ]]
    then
        read -p "How many items do you wish to order (1-20)?" num_o_items
    else
        read -p "So hun, how many items do you want to pig out on (1-20 ... 20? Really? " num_o_items
    fi
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
    file_dir="../files"
    menu_file=$file_dir$menu_name
elif [[ $this_dir == *"/bill/" ]]
then
    lib_dir="lib"
    file_dir="files"
    menu_file=$this_dir$file_dir"/"$menu_name
else 
  echo "You must run this script in bill's directory or bill's solution directory for the challenge."
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


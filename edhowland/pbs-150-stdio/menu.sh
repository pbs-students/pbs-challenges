#!/usr/bin/env bash
# menu.sh reads a file here and lists menu items. Asks for user to choose
# items until done. Finally printing the choices when done. Handles all possible
# errors including user input errors.

# Load messages. Will use dmesg fn to display them by number
source dmesg.sh
source options.sh
source load_menu.sh
echo $fname #;exit 9
load_messages $msg_fname
# The arrays: menu and choices
declare -a choices
# Read in the menu items  from the selected menu file
load_menu "$fname"
# set the limit to $max_items if  not already set by -l limit  in options.sh
test -z "$limit" && limit="$max_items"

# Main
dmesg 0 # Intro message

PS3=$(dmesg 1)
select food in done "${menu[@]}"
do
  [[ -z "$food" ]] && continue
  (( "${#choices[@]}"  >= "$limit" )) && { dmesg 5; break ;}
  [[ "$food" == "done" ]] && break
  choices+=("$food")
dmesg 2
done
dmesg 3
for item in "${choices[@]}"
do
  echo $item
done

dmesg 4 # Final speech

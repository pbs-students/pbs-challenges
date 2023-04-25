#!/usr/bin/env bash
# menu.sh reads a file here and lists menu items. Asks for user to choose
# items until done. Finally printing the choices when done. Handles all possible
# errors including user input errors.

# Setup variables like where we live and how to get our library path
PBS_ROOT=$(realpath "$(dirname $BASH_SOURCE)/..")
LIB=${PBS_ROOT}/lib
source ${LIB}/pbs-funcs.sh
# Load messages. Will use dmesg fn to display them by number
source dmesg.sh
msg_fname="std-messages.txt"
# remove me before push
msg_fname="snark-messages.txt"
load_messages $msg_fname
# The arrays: menu and choices
declare -a menu
declare -a choices
#load_array  breakfast_menu.txt menu1
# Read in the menu items  from the selected menu file
# Get the name of the file to read in, or use default if not supplied
fname="${1:-breakfast_menu.txt}"
# read each line into the menu array using here string. (Thanks Bart)
while read -r line
do
  menu+=( "$line" )
done <<< "$(egrep -v '(#.*$)|(^$)' $fname)"

# Main
dmesg 0 # Intro message

PS3=$(dmesg 1)
select food in done "${menu[@]}"
do
  [[ -z "$food" ]] && continue
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

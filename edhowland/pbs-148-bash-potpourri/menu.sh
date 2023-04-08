#!/bin/bash
# menu.sh reads a file here and lists menu items. Asks for user to choose
# items until done. Finally printing the choices when done. Handles all possible
# errors including user input errors.

# Setup variables like where we live and how to get our library path
PBS_ROOT=$(realpath "$(dirname $BASH_SOURCE)/..")
LIB=${PBS_ROOT}/lib
source ${LIB}/pbs-funcs.sh
# The arrays: menu and choices
declare -a menu
declare -a choices
choices=(pancakes coffee orange)
#load_array  breakfast_menu.txt menu1
# Read in the choices from the menu file
while read -r line
do
  menu+=( "$line" )
done <<< "$(egrep -v '(#.*$)|(^$)' breakfast_menu.txt)"

echo What will you have?
echo Here are some items we have on hand today
for i in ${!menu[@]}
do
  echo $i: ${menu[$i]}
done

echo Your choices are:
for item in ${choices[@]}
do
  echo $item
done

echo Comming right up

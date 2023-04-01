#!/bin/bash
source "../lib/inArray.sh"
a_test=("Fred Flinstone" "Barney" "Wilma Flinstone" "Betty")
a_data=("Fred Flinstone" "BamBam" "Dino" "Betty")
echo ${a_test[@]}
echo ${a_data[@]}
echo "Is In Array"
inArray "Fred" ${a_test[@]}
echo "test done"
echo ""
for this_thing in "${a_data[@]}"
do
    if inArray $this_thing $a_test
    then
      echo "Yep"
    else
      echo "Nope"
    fi
done
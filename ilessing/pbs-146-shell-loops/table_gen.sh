#!/usr/bin/env bash

# usage:
# table_gen [number [max number]]
#   generates a multiplication table for given [number]
#   defaults to ten rows.
#   if users provides a second argument it will be used 
#   as the number of rows in the table.

users_number=$1
users_max=$2

regularexp='^[0-9]+$'

# test if a second argument was provided
if [[ -z $users_max ]]
then
  # default range max to ten when none is provided
  range_max=10

  # error out if user provided a non-number as second argument
elif ! [[ $users_max =~ $regularexp ]]
  then 
    echo "error: Not a whole number" >&2; exit 1
  else
  range_max=$users_max
fi

if [[ -z $users_number ]]
then
    echo ""
    echo "I can produce multiplication tables for you. "
    echo " What multiplication table would you like to see?"
    read -p "Enter a number: " users_number
fi

# error out if user does not provide a whole number
if ! [[ $users_number =~ $regularexp ]] ; then
   echo "error: Not a whole number" >&2; exit 1
fi

echo "You want a multiplication table for ${users_number}.  Okay.  Can do."

for iteration in $(seq 1 $range_max)
do
	echo -n "${iteration} * ${users_number} = "
	echo "$iteration * $users_number" |bc
done

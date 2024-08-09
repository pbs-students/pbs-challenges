#!/usr/bin/env bash

# use the first arg as the initial value for the base number
base_number=$1

# keep asking for a valid base number until we get one
until echo "$base_number" | egrep -q '^[[:digit:]]+$'
do
    read -p "What's the base number? " base_number
done

# use the second arg as the stop number, defaults to 10
stop_number=$2
# if no second argument is passed, defaults to 10
if [[ -z $stop_number ]]
then
	stop_number=10
fi
# check value, and keep asking until valid value is passed
until echo "$stop_number" | egrep -q '^[[:digit:]]+$'
do
	read -p "What's the stop number? " stop_number
done

# create loop to print table
for i in $(seq $stop_number)
do
	result=$(bc <<< "$base_number * $i")
	echo "$i × $base_number = $result"
done
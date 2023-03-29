#!/usr/bin/env bash

# assume the first arg is the multiple table desired and second is the length
table=$1
length=$2

# supply help message
if [[ $table == "-h" ]] || [[ $table == "--help" ]]
then
    echo "Homework for PBS 146, pbs.bartificer.net."
    echo ""
    echo "Usage:"
    echo "    bash_hw.sh [<n>] [<length>]"
    echo " " 
    echo "    n           Multiplication table desired (optional)."
    echo "    length      Lenth of multiplication table (default: 10)."
    echo " "
    echo "Options:"
    echo "    -h --help   Show this help menu and exit"
    exit 0
fi

# check for and then ask to make sure it is an integer
until echo "$table" | egrep -q '^[0-9]+$'
do
    read -p "What multiplication table would you like? " table
done

# use length if given, or default to 10
if [[ -z $length ]]
then
    length=10
fi

for i in $(seq -s " " $length)
do
    result=$(echo "$i*$table" | bc)
    echo "$i x $table = $result"
done

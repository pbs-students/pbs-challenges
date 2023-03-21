#!/usr/bin/env bash
x=12
y=10

i=$x

# if [[ $i -le $y ]]
# then
# echo "true"
# else
# echo "false"
# fi
# 
# while [[ $i -le $y ]]
# 	do
# 		echo "x equals $i"
# 		((i=i+1))
# 	done

read -p "Do you want to define your own range for the times table? y or n (default of 1-10)" yesno
if [[ $yesno == 'yes' ]]
	then
		echo "booya"
	else
		echo "default is 1-10"
fi

regex= "^[0-9]+$"
if ! [[ "$number" =~ regex ]]


if ! [[ $number =~ $regex ]]
	then
		echo "that's not a number"
	else
fi
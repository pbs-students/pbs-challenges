#!/usr/bin/env bash
# Written by Allison Sheridan (aka @podfeet) in 2023 under the MIT license
# This script was written as a response to the challenge posted by
# Bart Busschots in Programming By Stealth 146 at https://pbs.bartificer.net/pbs146
# The challenge was written as:
	# If you’d like to put your Bash skills to the test, try writing a script that accepts a whole number as an input, either as the first argument or from a user prompt, then prints out the standard n-times multiplication tables to the screen, i.e., if you give the number 3, the output should be:
	
	# ```
	# 1 x 3 = 3
	# 2 x 3 = 6
	# 3 x 3 = 9
	# 4 x 3 = 12
	# 5 x 3 = 15
	# 6 x 3 = 18
	# 7 x 3 = 21
	# 8 x 3 = 24
	# 9 x 3 = 27
	# 10 x 3 = 30
	# ```
	
	# For bonus credit, update your script to allow the user to specify how high the table should go, defaulting to 10 like above.
#
# My solution goes a bit beyond and allows the user to define the specific range, not just 1-x

# use the first argument as the number if it was given
number=$1
rangemin=$2
rangemax=$3

# Define a regular expression for a whole number to check each value against
# Optional + or - sign followed by one or more digits from 0 to 9
# This allows whole positive or negative numbers
regex=^[+-]?[0-9]+$

# until statement to see if an argument was provided
# if no argument was provided ask for one
# code to make sure it's really a whole number

if [[ -z $number ]] # if no arguments were supplied
	then
		# Ask user for the whole number to multiply and optionally to define the range
			read -p "Give me a whole number and I'll show you the times table for it: " number
			until [[ $number =~ $regex ]]
				do
					read -p "That was not a whole number, try again: " number		
				done	
				# ask if user wants to define the range. If they answer anything but yes, it will use the default of 1-10
				read -p "Do you want to define the range for the times table? Type yes (y) or no (n or enter) " yesno
				# Quotes added around var $yesno otherwise I get a unary operator error
				# Without the quotes, if the value doesn't exist, the variable vanishes, leaving if [ = "yes"]
				# Single [] brackets are POSIX compatible. If I used double [] brackets I wouldn't need the "" around var
				if [[ $yesno == 'yes' ]] || [[ $yesno == 'y' ]] || [[ $yesno == 'Y' ]] || [[ $yesno == 'YES' ]]
				# if [ "$yesno" == 'yes' ] || [ "$yesno" == 'y' ] || [ "$yesno" == 'Y' ] || [ "$yesno" == 'YES' ]
					then
						# Keep asking till the user supplies a whole number for range min	
						# Ask user for range minimum and assign to variable rangemin
						read -p "Give me the MINIMUM value by which you want to multiply: " rangemin		
						# ***********
						until echo "$rangemin" | egrep -q $regex
						# ****************
							do
								read -p "That was not a whole number, try again: " rangemin	
							done
						# Keep asking till the user supplies a whole number for range max
						read -p "Now give me the MAX value by which you want to multiply: " rangemax
						until echo "$rangemax" | egrep -q $regex
							do
								 read -p "That was not a whole number, try again: " rangemax
							done
				else
					rangemin=1
					rangemax=10
				fi
else
	number=$1
	if [[ $number =~ $regex ]]
		then
			if [[ -z $2 ]] # if there is no second argument, there cannot be a third so do not worry about it
				then # set range min/max to defaults
					rangemin=1
					rangemax=10
				else # assume there is a second and third argument and use them
					# if there is no third argument, it multiplies down to zero. That sure is convenient!
					rangemin=$2
					rangemax=$3
			fi
		else
			echo "That was not a whole number"
		fi
fi

# Check to see if they put in a bigger min than max, and count down instead if so
if [[ $rangemin -le $rangemax ]]
	then
			while  [[ $rangemin -le $rangemax ]]
			do 
			# use `bc` basic calculator to do the arithmetic
				answer=`echo "$rangemin*$number" | bc`
				echo "$rangemin x $number = $answer"	
				((rangemin=rangemin+1))
			done
	else
		while  [[ $rangemin -ge $rangemax ]]
			do
				# use `bc` basic calculator to do the arithmetic
				answer=`echo "$rangemin*$number" | bc`
				echo "$rangemin x $number = $answer"	
				# decrement rangemin to count down
				((rangemin=rangemin-1))
			done
fi
			

		
	

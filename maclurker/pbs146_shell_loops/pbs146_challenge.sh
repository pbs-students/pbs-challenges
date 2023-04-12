#!/usr/bin/env bash

#**********************************************
# PBS 146 challenge: output a multiplication table
#
# Created on: March 6, 2023
#
# Usage: ./pbs146_challenge.sh -ml <multiplier number> [-st <starting iteration>] [-sz <size of table>]
#
#**********************************************
defaultSize=10
maxSize=20
startNum=1
size2=$defaultSize
num="abc"

#-----------------------------------------------
# process input parameters: <number> <end>
#-----------------------------------------------
argcnt=$#
echo "have "$argcnt" command line arguments"
# use $#

if [[ $argcnt -ne 0 && $argcnt -ne 2 && $argcnt -ne 4 && $argcnt -ne 6 ]]
then
    echo "*** Invalid number of arguments"
    exit 1
fi

i=1;
while [ $i -le $argcnt ] 
do
    echo "param - $i: $1";
    i=$((i + 1));
    param=$1;

    #    get next param currently $1
    shift 1;
    echo "param - $i: $1";
    i=$((i + 1));
    
    # case on $param
    case $param in
        -ml )
            echo 'have multiplier param'
            # keep asking for a valid number until we get one
            num=$1
            until echo "$num" | egrep -q '^[0-9]+$'
            do
                read -p "Enter a number: " num
            done
        ;;
        -st )
            echo 'have starting number param'
            # make sure input is a number. Use default if not
            if echo $1 | egrep -q '[0-9]'
            then
               startNum=$1
            fi

        ;;
        -sz )
            echo 'have table size param'
            # make sure input is a number. Use default if not
            if echo $1 | egrep -q '[0-9]'
            then
                size2=$1
            fi

        ;;
        * )
            # invalid parameter name. Leave now
            echo "*** invalid argument: "$param
            exit 1
    esac
    shift 1;
done

until echo "$num" | egrep -q '^[0-9]+$'
do
    read -p "Enter a number: " num
done
    
# limit size of table
if [[  $size2 -gt $maxSize || $size2 -lt 0 ]]
then
    echo "*** Limiting size of table to "$maxSize
    size2=$maxSize
fi

#-----------------------------------------------
# output requested multiplication table
#-----------------------------------------------
echo "OUTPUT IS ==============="
echo "the number is "$num
echo "the size is "$size2
echo "starting number is "$startNum
endNum=$((startNum+size2-1))

# loop over sequence of 0 to max-num
for iter in $(seq $startNum 1 $endNum)
do
#    Calculate multiplication results: echo <num> * <iter> | bc     
#    Display results
    echo $iter" x "$num" = "`echo "$num*$iter" | bc`
done
# end loop

#-----------------------------------------------
# exit
#-----------------------------------------------
echo "All done! Bye bye!"
exit 0
    
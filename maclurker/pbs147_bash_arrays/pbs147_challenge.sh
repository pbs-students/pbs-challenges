#!/usr/bin/env bash

#**********************************************
# PBS 147 & 148 challenge: Use bash arrays to take a user's breakfast order
#
# Created on: April 13, 2023
#
# Modified on:
#       April 18, 2023: limit number of items that can be ordered
#           one time; Allow custom orders
#
# Usage: ./pbs147_challenge.sh [-f input-filename] [-c max-items]
#
#**********************************************
#-----------------------------------------------
# Initialization
#-----------------------------------------------
# init variables
vers="1.04"
defaultMaxItems=''

# init order array
declare -a orderArray

#-----------------------------------------------
# process input parameters: -f <filename> -c <max-items>
#-----------------------------------------------
argcnt=$#
# use $#
##echo "have "$argcnt" command line arguments"

# if there is no command line arg, use default menu & max items
# create the default menu array
menuArray=(biscuits Cheerios 'eggs, poached' 'eggs, over-easy' 'french toast' muesli omelet waffles milk 'cinnamon sugar' gravy grits 'maple syrup' sausage)
maxItems=$defaultMaxItems

#loop through arguments & process. If invalid, keep defaults
i=1;
while [ $i -le $argcnt ] 
do
    ##echo "param - $i: $1";
    i=$((i + 1));
    param=$1;
    
    #    get next param currently $1
    shift 1;
    ##echo "param - $i: $1";
    i=$((i + 1));
    
    # case on $param
    case $param in
        #+++++++++++++++++++++++++
        # process file name input parameter
        #+++++++++++++++++++++++++
        -f )
            # if we have an input param, assume it's the name of a file with the menu info
            menuFile=$1
            echo "our input file name is $menuFile"
            
            # test if file exists. Exit with error if not
            if [[ ! -r $menuFile ]]
            then
                echo "*** Unknown file: $menuFile "
                exit 1
            elif [[ -d $menuFile ]]
            then 
                # make sure it's not a directory either
                echo "*** This is a directory; must specify a text file : $menuFile "
                exit 1
            fi
            
            # process file contents into menuArray variable, skipping empty & comment lines
            # first remove default menu items
            unset menuArray 
            ##echo "start read loop"
            while read line || [[ $line ]]; do
                ##echo $line
                # skip empty lines
                if [[ ! -z $line ]]
                then
                    # skip comment lines
                    if echo $line | egrep -qv '^#'
                    then
                        menuArray+=("$line")
                    fi
                fi
            done < ${menuFile}
        ;;
        #+++++++++++++++++++++++++
        # process maximum number of order items input parameter
        #+++++++++++++++++++++++++
        -c )
            ##echo 'have max order items param'
            # make sure input is a number. Use default if not
            if echo $1 | egrep -q '^[1-9][0-9]*$'
            then
                maxItems=$1
            else
                echo "*** -c argument value is invalid ($1). Defaulting to unlimited items"
            fi
            
        ;;
        #+++++++++++++++++++++++++
        # process any other input
        #+++++++++++++++++++++++++
        * )
            # invalid parameter name. Leave now
            echo "*** invalid argument: "$param
            exit 1
    esac
    shift 1;
done

# show # items in the menu less the terminator
menuCnt=${#menuArray[@]}
echo "There are $menuCnt items in our breakfast menu"
if [[ $maxItems -eq $defaultMaxItems ]]
then
    echo "An unlimited number of items can be ordered"
else
    echo "A maximum of $maxItems items can be ordered"
fi

# error if file is empty or contains no menu items
if [[ $menuCnt -le 0 ]]
then
    echo "*** Menu is empty"
    exit 1
fi

# always add menu terminator at beginning of array
menuArray=("I am done" "${menuArray[@]}")
# add menu option for custom orders
menuArray+=("I want something else")

#for item in "${menuArray[@]}"
#do
#   echo "* $item"
#done

#-----------------------------------------------
# Main loop
#-----------------------------------------------
# use select loop to get user's order
echo "Menu selections, limited to $maxItems selections ($vers) ---"
PS3="Please add to the meal order, by entering the related number: "
select bi in "${menuArray[@]}"
do
    ##echo "User selected -$bi-"

    # don't store invalid entries (input is empty string)
    [[ -z $bi ]] && continue 
    
    # see if we are done
    [[ $bi == 'I am done' ]] && break

    # process custom item, as entered by user
    if [[ $bi == "I want something else" ]]
    then
        read -p "What do you want, exactly? " customItem
        orderArray+=("$customItem <<<")
    else 
        # otherwise use item string as provided by select
        orderArray+=("$bi")
    fi
    
    # if max items provided, compare with # items now ordered
    if [[ -n $maxItems ]]
    then
        # exit loop if reach max items to be ordered
        [[  ${#orderArray[@]} -ge $maxItems ]] && break
    fi
done

#-----------------------------------------------
# Print order
#-----------------------------------------------
orderCnt=${#orderArray[@]}
if [[ $orderCnt -eq 1 ]]
then
    wasWere="was"
    itemStr="item"
else
    wasWere="were"
    itemStr="items"
fi 
echo "$orderCnt $itemStr $wasWere ordered."
# use for loop to print user's order
for item in "${orderArray[@]}"
do
    echo "* $item"
done

#-----------------------------------------------
# exit
#-----------------------------------------------
echo "All done! Bye bye!"
exit 0
    
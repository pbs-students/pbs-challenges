#!/usr/bin/env bash

#**********************************************
# PBS 149 challenge: Use bash arrays & getopts to take a user's breakfast order
#
# Created on: April 19, 2023
#
# Modified on:
#
# Usage: ./pbs149_challenge.sh [-s] [-f input-filename] [-c max-items]
#   where: s is snark or no snark
#
#**********************************************
#-----------------------------------------------
# Initialization
#-----------------------------------------------
# init variables
vers="2.01"
defaultMaxItems=''

# init order array
declare -a orderArray

#-----------------------------------------------
# process input parameters: -s -f <filename> -c <max-items>
#-----------------------------------------------
argcnt=$#
# use $#
##echo "have "$argcnt" command line arguments"

# set param data to defaults
# if there is no command line arg, use default menu & max items
# create the default menu array
menuArray=(biscuits Cheerios 'eggs, poached' 'eggs, over-easy' 'french toast' muesli omelet waffles milk 'cinnamon sugar' gravy grits 'maple syrup' sausage)
maxItems=$defaultMaxItems
snarkFlag=''

#loop through arguments & process. If invalid, keep defaults
while getopts ':sc:f:' opt 
do
    # case on $param
    case $opt in
        #+++++++++++++++++++++++++
        # process maximum number of order items input parameter
        #+++++++++++++++++++++++++
        c )
            ##echo 'have max order items param'
            # make sure input is a number. Use default if not
            if echo $OPTARG | egrep -q '^[1-9][0-9]*$'
            then
                maxItems=$OPTARG
            else
                echo "*** -c argument value is invalid ($OPTARG). Defaulting to unlimited items"
            fi
            
        ;;
        #+++++++++++++++++++++++++
        # process file name input parameter
        #+++++++++++++++++++++++++
        f )
            # if we have an input param, assume it's the name of a file with the menu info
            menuFile=$OPTARG
            ##echo "our input file name is $menuFile"
            
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
        # process snark/no snark input
        #+++++++++++++++++++++++++
        s )
            ##echo "have snark flag"
            snarkFlag=1
        ;;
        #+++++++++++++++++++++++++
        # process any other input
        #+++++++++++++++++++++++++
        ? )
            # invalid parameters. Leave now
            echo "*** Usage: $(basename $0) [-s] [-f <filename>] [-c <max-items>]"
            exit 1
    esac
done 
# remove the options from the args
shift $(echo "$OPTIND-1" | bc)

# show # items in the menu less the terminator
menuCnt=${#menuArray[@]}

# error if file is empty or contains no menu items
if [[ $menuCnt -le 0 ]]
then
    echo "*** Menu is empty"
    exit 1
fi
            
echo "There are $menuCnt items in our breakfast menu"
if [[ $maxItems -eq $defaultMaxItems ]]
then
    ##echo "An unlimited number of items can be ordered"
    maxItemsStr="with NO limits to"
else
    ##echo "A maximum of $maxItems items can be ordered"
    maxItemsStr="limited to $maxItems"
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
echo "Menu selections, $maxItemsStr selections ($vers) ---"
PS3="Please add to the meal order by entering the related number: "
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

#show state of snark flag
if [[ -n $snarkFlag ]]
then
    echo '>>> Snark was requested, but frankly, I cannot be bothered. Do your own. <<<'
fi
            
# set up order count message
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
    
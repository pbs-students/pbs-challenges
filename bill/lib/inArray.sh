#!/bin/usr/env bash
# First are is value to find in the array
# Following args are the values in the array.
inArray() {
  counter=1
  is_yes="No"
  for the_arg in "$@"
  do    
    if [[ $counter -gt 1 ]]
    then 
      if [[ $the_arg = $1 ]]
      then
        is_yes="Yes"
        break
      fi
    fi
    ((counter++))
  done
}

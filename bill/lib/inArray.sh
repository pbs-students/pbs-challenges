#!/bin/usr/env bash
inArray() {
  counter=1
  for the_arg in "$@"
  do
    if [[ $counter -gt 1 ]]
    then 
      if [[ $the_arg = $1 ]]
      then
        exit 0
      fi
    fi
    ((counter++))
  done
  exit 1
}

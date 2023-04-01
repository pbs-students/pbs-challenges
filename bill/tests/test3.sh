#!/bin/usr/env bash
inArrayTest3() {
  echo $1
  echo ""
  num_o_args=$#
  echo $num_o_args
  echo ""
  counter=1
  for the_arg in "$@"
  do
    if [ $counter -gt 1 ]
    then
      echo $the_arg
    fi
    ((counter++))
  done
  echo ""
  echo $2
  echo $3
}

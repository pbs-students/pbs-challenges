#!/bin/usr/env bash
getArray() {
  IFS=$'\n'
  a_array=()
  while read -r line
  do
    a_array+=("$line")
  done < "$1"
}


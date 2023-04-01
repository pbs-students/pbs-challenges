#!/bin/usr/env bash
echo "pwd: "$PWD
source $PWD"/lib/getArray.sh"
file_w_path=$(dirname $BASH_SOURCE)"/test.txt"
echo $file_w_path
getArray "$file_w_path"
for i in ${a_array[@]};
do
  echo "$i"
done

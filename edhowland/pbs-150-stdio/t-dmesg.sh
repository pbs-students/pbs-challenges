#!/usr/bin/env bash
# t-dmesg.sh tests for dmesg.sh
source dmesg.sh
fname=${1:-std-messages.txt}
load_messages $fname
echo messages are:
for i in "${messages[@]}"
do
  echo $i
done



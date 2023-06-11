#!/usr/bin/env bash
#  multi-table.sh
positive_whole_num() {
  ! [[ "$1" =~ [0-9]+\. ]] && (( "$1" >= 1 ))
}
print_table() {
  n=$1; min=$2; max=$3
  for x in $(seq $min $max)
  do
    let product=${n}*${x}
    echo "${n} X ${x} = ${product}"
  done
}
# main
num="${1:-0}"
max="${2:-10}"
until positive_whole_num "$num"
do
  read -p "Enter a positive whole number:" num
done
print_table $num 1 "$max"

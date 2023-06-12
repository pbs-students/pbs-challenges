#!/usr/bin/env bash
shopt -s expand_aliases
# This line needed to expand aliases within

#  multi-table.sh
source die_unless.sh

# return true if arg is a positive whole number
positive_whole_num() {
  ! [[ "$1" =~ [0-9]+\. ]] && (( "$1" >= 1 ))
}
alias must_be_positive='die_unless positive_whole_num'
# Actually print out the multiplication table in a nicely formatted output
print_table() {
  n=$1; min=$2; max=$3
  for x in $(seq $min $max)
  do
    let product=${n}*${x}
    printf '% 6d X % 6d = % 6d\n' "$n" "$x" "$product"
  done
}
# main
min=1; max=10
Usage="$(basename $0) [-m minimum] [-M maxinum] multiplicand"
while getopts ':m:M:' OPT
do
  case $OPT in
    m)
      min=$OPTARG;;
    M)
      max=$OPTARG;;
    ?)
      eprintf "$Usage\n"
      exit 2;;
  esac
done
shift $((OPTIND - 1))
must_be_positive $min "Minimum must be a positive whole number" 3
must_be_positive $max "Max must be a positive whole number" 4


num="${1:-0}"
until positive_whole_num "$num"
do
  read -p "Enter a positive whole number:" num
done
print_table $num "$min" "$max"

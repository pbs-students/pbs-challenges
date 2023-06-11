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
min=1; max=10
Usage="$(basename $0) [-m minimum] [-M maxinum] number"
while getopts ':m:M:' OPT
do
  case $OPT in
    m)
      min=$OPTARG;;
    M)
      max=$OPTARG;;
    ?)
      echo $Usage
      exit 2;;
  esac
done
shift $((OPTIND - 1))
if  ! positive_whole_num "$min" 
then
  echo Minimum must be a positive hole number
  echo $Usage; exit 3
fi
if  ! positive_whole_num "$max" 
then
  echo Maximum must be a positive whole number
  echo $Usage; exit 4
fi
num="${1:-0}"
until positive_whole_num "$num"
do
  read -p "Enter a positive whole number:" num
done
print_table $num "$min" "$max"

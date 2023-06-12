#!/usr/bin/env bash
shopt -s expand_aliases


Usage=$(basename $0)
source die_unless.sh
positive_whole_num() {
  ! [[ "$1" =~ [0-9]+\. ]] && (( "$1" >= 1 ))
}

alias must_be_positive='die_unless positive_whole_num'
must_be_positive $1 'bad juju' 7 'test.sh positive_number'


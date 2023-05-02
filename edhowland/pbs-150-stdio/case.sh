#!/usr/bin/env bash
# sample case statement
variable=$1
case $variable in
pattern-1)
  echo you chose $variable which is pattern-1;;
pattern-2)
  echo you chose $variable which is pattern-2;;
pattern-3)
  echo you chose $variable which is pattern-3;;
pattern-N)
  echo you chose $variable  which is pattern-N;;
*)
  echo wrong choice;;
esac




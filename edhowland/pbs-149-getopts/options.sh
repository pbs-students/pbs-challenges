#!/usr/bin/env bash
# check for -m menufile.txt, -l limit and -s A bool option for snarkiness
usage=$(
cat<<EOD
$(basename $0) [-m menufile.txt] [-l limit_choices] [-s]
  Where -m menu_file.xt is file of menu choices. [default: breakfast_menu.txt]
    - l <number> : Limits the number of choices user can make.
    -s : Use snark-messages.txt for prompts instead of std-messages.txt
EOD
)
fname="breakfast_menu.txt"
msg_fname="std-messages.txt"
limit=""
snark="N"
while getopts ':m:l:s' OPT
do
  case $OPT in
    m)
      fname=$OPTARG
test -f $fname || { echo No such file: $fname; exit 2; };;
    l)
      limit=$OPTARG;;
    s)
      msg_fname="snark-messages.txt";;
    \:)
echo Bad value for argument $OPT
      echo "$usage";;
    \?)
  echo "$usage"; exit 2;;
    *)
      echo Bad option $OPT; exit 2
  esac
done

fname=${fname:-breakfastmenu.txt}
snark=${snark:-N}

# source this file: dmesg.sh
# dmesg.sh fn dmesg messages.txt
declare -a messages
load_messages() {
  test -f $1 || { echo No such file $1 for messages; exit 3; }
  while read -r line
  do
    messages+=( "${line}" )
  done <<< "$(cat $1)"
}
dmesg() {
  echo "${messages[$1]}"
}




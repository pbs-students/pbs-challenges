# source this file: load_menu.sh
declare -a menu
load_menu() {
  mname="$1"
  if [[ "$mname" == "-" ]]
  then
    mname=""
  else
    test -f "$mname" || { echo No such file "$mname"; exit 3; }
  fi
  while read -r line
  do
    echo "$line" | egrep '^#.*$' >/dev/null && continue
    menu+=( "$line" )
  done <<< "$(cat $mname)"
  max_items="${#menu[@]}"
}

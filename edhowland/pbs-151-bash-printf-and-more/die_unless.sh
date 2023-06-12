# Put this line at the top of the file before sourcing this file
# shopt -s expand_aliases
# source die_unless.sh
eprintf() {
  printf "$1" "$2" >&2
}

die_unless() {
  cmd="$1"; val="$2"; msg="$3"; excode="${4:-1}"; usage="${5:-$Usage}"
  $cmd $val || { eprintf '%s\n' "$msg"; echo $usage >&2; exit $excode ;}
}


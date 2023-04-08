# source this file
# pbs-functs.sh support fns for PBS challenges
# load_array(fname, array) - given the name of a possible fname, load items one
# per line into array skipping comments and blank lines
load_array() {
  array=${!2}
  echo "${array}[1] is ${array[1]}"
  echo "${array}[2] is ${array[2]}"

}

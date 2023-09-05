#!/usr/bin/env nu
source load.nu # Pulls in sources and modules

def mk-full-title [number: int] {
  format str prepend 'pbs' $number
}


# pulls .zip from current show notes page and formats previous solution
# folders and text
def main [
    curr: int
    --suffix (-s): string
    --heading (-l): string
  ] {
  let prev = ($curr - 1)
  # (possibly) set the value of $env.auto_config values
  cfg set suffix $suffix
  cfg set heading $heading

  # possibly remove old dedetritus from previous runs
  rm -rf ./pbs*/ current.zip previous.html
  http get (format show url $prev) | save -f previous.html
  let dirname = $"(repo git root)/bart/(open previous.html | webq show id | format show title | mk-full-title $prev)"
  let readme = $"(repo git root)/bart/readme.md"
  let solution_file = (format challenge file $prev)
  http get (format zip url $curr) | save -f  current.zip
  unzip -o  -qq current.zip
  mkdir $dirname
  cp -u $"pbs($curr)/($solution_file)" $dirname
  open $readme | markdown compose ($dirname | path basename) (open previous.html | webq show challenge-text | fold -s) ($prev) | save -f $readme
}

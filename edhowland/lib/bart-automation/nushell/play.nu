# play.nu: playing around with things in automate.nu in the REPL
source load.nu
def mk-full-title [number: int] {
  format str prepend 'pbs' $number
}


config set header h3
let prev = 152
  let dirname = $"(repo git root)/bart/(open previous.html | webq show id | format show title | mk-full-title $prev)"
  let readme = $"(repo git root)/bart/readme.md"
  let solution_file = (format challenge file $prev)

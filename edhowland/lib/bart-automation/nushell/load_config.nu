# load_config.nu : sets $automate-config

let automate_config = {
  urlbase: "https://pbs.bartificer.net/pbs",
  zipbase: "https://github.com/bartificer/programming-by-stealth/raw/master/instalmentZips/pbs",
  solution_suffix: "challengeSolution.sh", # could be challengeSolution.js
  challenge_heading_level: "h2", # In some older challenges was h3
  challenge_regex: "Optional Challenge|Bonus|Homework",
  readme_marker_start: "##### Challenges are below this line", # This line is replaced with this line + contents of challenge from show notes
}


# mutable value of $automate_config record
$env.auto_config = $automate_config

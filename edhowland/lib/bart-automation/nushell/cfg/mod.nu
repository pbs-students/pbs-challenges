# various commands setting, reading the value of $automate_config var.
# Must source 'load_config.nu before calling any of these functions

export def heading [] -> string {
  $env.auto_config.challenge_heading_level
}


# get the value of $env.auto_config.solution_suffix
export def suffix [] {
  $env.auto_config.solution_suffix
}


# reset the config settings back to the value of those loaded by load_config.nu
export def-env reset [] {
  $env.auto_config = $automate_config
}

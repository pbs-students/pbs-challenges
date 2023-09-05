# set values (if not empty) in mutable $config

# set the value of $env.auto_config.challenge_heading_level
export def-env heading [level: string] {
  if not ($level | is-empty) {
    $env.auto_config.challenge_heading_level = $level
  }
}


# 


# set the value of $env.auto_config.solution_suffix to suffix
export def-env suffix [suffix: string] {
  if not ($suffix | is-empty) {
    $env.auto_config.solution_suffix = $suffix
  }
}


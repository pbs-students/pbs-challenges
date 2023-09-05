# get things from show page . expects input to be HTML

# return id attribute of second H1
export def  id [] {
  query web -q h1 --attribute id | select 1 | get 0
}


#gets the index of  the   heading level as specified in config where content matches regex specified in config
export def challenge-item [] {
  query web -q $env.auto_config.challenge_heading_level | enumerate | where item =~ $env.auto_config.challenge_regex | get index | get 0
}


# returns the text of the p tag that follows the previous headin from challenge-item
export def challenge-text [] {
  query web -q $"($env.auto_config.challenge_heading_level) + p" | last
}

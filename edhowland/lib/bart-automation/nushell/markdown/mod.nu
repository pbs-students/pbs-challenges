# various commands and subcommands for dealing with Markdown files

# prepends the 2 values back into the replacement string
# First: The .readme_marker_start
# Second: Some newlines and then the heading 2 with the full show title
export def prepend [title: string, newstr: string] {
  $"($env.auto_config.readme_marker_start)\n\n($title)\n\n($newstr)\n"
}


# replaces the string matching the .readme_marker_start with formatted replacement text
export def replace [text: string] {
  str replace $env.auto_config.readme_marker_start $text
}


# composes the replacement text from readme_marker_start and full title
# and challenge text. Does by executing  2 closures
export def compose [title: string, challenge: string, number: int] {
  str replace $env.auto_config.readme_marker_start $"\n($env.auto_config.readme_marker_start)\n\n## ($title)\n\n($challenge)\n\n[PBS ($number) show notes]\((format show url $number)\)\n"
}

export def root [] {
  git rev-parse --show-toplevel | str trim -r
}

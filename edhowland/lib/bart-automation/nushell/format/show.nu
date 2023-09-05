# show submodule

# returns the URL of the passed in show number
export def url [number: int] {
  $"($env.auto_config.urlbase)($number)"
}


# returns the part of the show id after the '--'
export def title [] {
  let inp = $in
  let offset = ($inp | str index-of '--')
  let rng = ($offset + 2)..
  $inp | str substring $rng
}


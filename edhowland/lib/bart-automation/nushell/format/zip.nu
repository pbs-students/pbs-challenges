# the format of the URL for this installment's .zip file
export def url [number: int] {
  $"($env.auto_config.zipbase)($number).zip"
}

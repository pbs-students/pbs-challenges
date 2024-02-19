[
  .prizes[] 
  | select(has("laureates")) 
    | {year: (.year | tonumber), 
      prize: .category, 
      numWinners: (.laureates | length), 
      winners: [
        .laureates[]? | (select (has("surname")) 
        | "\(.firstname) \(.surname)") // "\(.firstname)"
      ]
    }
  ] 
  # | @json <-- use if you want compact json not pretty
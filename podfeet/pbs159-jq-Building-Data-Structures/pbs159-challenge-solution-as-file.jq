jq '[.prizes[] 
  | select(has("laureates")) 
  | {year: ().year | tonumber), 
    prize: .category, 
    numWinners: (.laureates | length), 
    winners: [.laureates[]? 
    | "\(.firstname) \(.surname)" 
    | rtrimstr(" null")]}]' NobelPrizes.json

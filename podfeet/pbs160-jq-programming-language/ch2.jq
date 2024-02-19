# [
#   .prizes[] 
#   | select(
#     (.year | tonumber >= 
#         ($ARGS.named.minYear 
#         // 
#         ([.prizes[] | .year | tonumber] | min) | debug("minYear is \(.)"))
#       and (
#     ((.year | tonumber) <= 
#         ($ARGS.named.maxYear // 
#         ([.prizes[] | .year | tonumber] | max) | debug("maxYear is \(.)")
#         )))   
#         )
#       )
#   | select(any(.laureates[]?; 
#     "\(.firstname) \(.surname)"
#     | ascii_downcase
#     | contains($search | ascii_downcase)
#   ))
# ]


# [
# # debug ("minYear is \($ARGS.named.minYear)")
#  # | debug ("maxYear is \($ARGS.named.maxYear)")
#  .prizes[] 
#  | select((.year | tonumber >= ($ARGS.named.minYear // 
#       ([.prizes[] | .year | tonumber] | min | debug))) # returns 1901
#      and (((.year | tonumber) <= ($ARGS.named.maxYear // 
#       ([.prizes[] | .year | tonumber] | max)))) # returns 2023
#      )
#  | select(any(.laureates[]?; 
#    "\(.firstname) \(.surname)"
#    | ascii_downcase
#    | contains($search | ascii_downcase)
#  ))
# ]

[
# debug ("minYear is \($ARGS.named.minYear)")
 # | debug ("maxYear is \($ARGS.named.maxYear)")
 .prizes[] 
 | select((.year | tonumber >= ($ARGS.named.minYear // 
      ([.prizes[] | .year | tonumber] | min))) # returns 1901
     and (((.year | tonumber) <= ($ARGS.named.maxYear // # year to number is null
      ([.prizes[] | .year | tonumber] | max )))) # returns 2023
     )
 | select(any(.laureates[]?; 
   "\(.firstname) \(.surname)"
   | ascii_downcase
   | contains($search | ascii_downcase)
 ))
]

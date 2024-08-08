# Build a lookup-type dictionary of Nobel Prize records by year.

# The basic structure of the solution should be:

# {
#   "1901": [
#     { PRIZE RECORD }
#     …
#     { PRIZE RECORD }
#   ],
# 	…
# 	"2023": [
#     { PRIZE RECORD }
#     …
#     { PRIZE RECORD }
#   ]
# }

# need a to do a group_by year thing
jq '.[] | group_by(.year)' NobelPrizes.json > waffles.json

# That created
[
  [
    {
      "year": "1901"
          "category": "chemistry",
            "laureates": [
              # blah blah blah
              ]
    }
    {
      "year": "1901"
          "category": "chemistry",
            "laureates": [
              # blah blah blah
              ]
    }
  ]
]

jq '.[] | group_by(.year) | [.[] | {key: (.[0].year | tostring), value: [.[] | .]}] | from_entries' NobelPrizes.json > pancakes.json

jq '
# explode the array
.[] 
  # group the prizes by year
  | group_by(.year) 
  | 
  # create an array
  [
    # explode some array again?
    .[] 
      # create a dictionary with the key year, and the value of the prize for that year
      | {
        key: (.[0].year | tostring), 
        value: [.[] | .]
        }
  ] 
        # pipe this to from-entries to make it a lookup
        | from_entries' 
        NobelPrizes.json > pancakes.json

# I think that worked but each record has the year repeated so let's delete that

jq '.[] | group_by(.year) | [.[] | {key: (.[0].year | tostring), value: [.[] | .]} | del(.value.year)] | from_entries' NobelPrizes.json > scones.json

jq '
# explode the array
.[] 
  # group the prizes by year
  | group_by(.year) 
  | 
  # create an array
  [
    # explode some array again?
    .[] 
      # create a dictionary with the key year, and the value of the prize for that year
      | {
        key: (.[0].year | tostring), 
        value: [.[] | .]
        }
        | del(value.year)
  ] 
        # pipe this to from-entries to make it a lookup
        | from_entries' 
        NobelPrizes.json > scones.json

# doesn't work because this:
jq '. | ."1901"' pancakes.json

# returns all of the 1901 stuff. I guess to delete "year": "1901" I have to go into each year.  I know .[0]!

jq '. | .[0] | del(.value.year)' pancakes.json > eggs.json
# cannot index object with number
# duh the group_by year is not part of an array

jq '. | .value.[0]' pancakes.json
# null
jq '. | .key.[0]' pancakes.json
# null

jq '. | {"1901"}' pancakes.json
# returns all of the 1901s

jq '. | {key}' pancakes.json
# {
#   "key": null
# }

# let's back up. Maybe I didn't build pancakes properly

jq '
# explode the array
.[] 
  # build an entry for each child array
  | {
      key: (.[0].year | tostring), 
      value: [
        # explode the child array
        .[]
      # extract the year from each record
      | .year
      ]
    }
  # group the prizes by year
  | group_by(.year) 

  # pipe this to from-entries to make it a lookup
  | from_entries' 
  # file from to
  NobelPrizes.json > pancakes.json

jq '.[] | {key: (.[0].year | tostring), value: [.[] | .year]} | group_by(.year) | from_entries' NobelPrizes.json > pancakes2.json
# canot index string with string "year"

jq '
[
# explode the array
.[] 
  # group the prizes by year
  | group_by(.year) 
  | 
  # create an array
  [
    # explode some array again?
    .[] 
      # create a dictionary with the key year, and the value of the prize for that year
      | {
        key: (.[0].year | tostring), 
        value: [.[] | .]
        }
  ] 
        # pipe this to from-entries to make it a lookup
        | from_entries       
]' 
 NobelPrizes.json > bananas.json

 jq '[.[] | group_by(.year) | .[] | [{key: (.[0].year | tostring), value: [.[] | .]}] | from_entries]' NobelPrizes.json > apples.json

 # this is identical to this earlier one except it has an array around the whole thing:

 jq '.[] | group_by(.year) | [.[] | {key: (.[0].year | tostring), value: [.[] | .]}] | from_entries' NobelPrizes.json > pancakes.json

# try to delete extra year:
jq '[.[] | group_by(.year) | .[] | [{key: (.[0].year | tostring), value: [.[] | .]}] | from_entries | del(.value.year)]' NobelPrizes.json > apples.json
# didn't change the file at all

# move delete before from_entries
jq '[.[] | group_by(.year) | .[] | [{key: (.[0].year | tostring), value: [.[] | .]}] | del(.value.year) | from_entries]' NobelPrizes.json > apples.json
# Cannot index array with string "value"
  


# My solution where I said I thought it worked is the same format as Bart's answer! Repeating here:
jq '.[] | group_by(.year) | [.[] | {key: (.[0].year | tostring), value: [.[] | .]}] | from_entries' NobelPrizes.json > pancakes.json

jq '
# explode the array
.[] 
  # group the prizes by year
  | group_by(.year) 
  | 
  # create an array
  [
    # explode some array again?
    .[] 
      # create a dictionary with the key year, and the value of the prize for that year
      | {
        key: (.[0].year | tostring), 
        value: [.[] | .]
        }
  ] 
        # pipe this to from-entries to make it a lookup
        | from_entries' 
        NobelPrizes.json > pancakes.json
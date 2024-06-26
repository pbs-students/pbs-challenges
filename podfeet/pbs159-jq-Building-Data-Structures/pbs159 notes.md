# PBS 159 Challenge

**********************
# SUCCESS ON CHALLENGE
**********************
# get rid of non-laureates by selecting the prizes that do have laureates using what I learned from ChatGPT
jq '[.prizes[] | select(has("laureates")) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | "\(.firstname) \(.surname)" | rtrimstr(" null")]}]' NobelPrizes.json
>  winner winner chicken dinner

*************************
# SUCCESS ON EXTRA CREDIT
*************************
jq '[.prizes[] | select(has("laureates")) | {year: (.year | tonumber), prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | (select (has("surname")) | "\(.firstname) \(.surname)") // "\(.firstname)"]}]' NobelPrizes.json

********************
EVERYTHING I TRIED
********************

jq '.prizes[] | .year | tonumber' NobelPrizes.json
> all of the years of all of the prizes as numbers

jq '.prizes[] | {year: .year | tonumber, prize: .category}' NobelPrizes.json
> all years (as numbers) and prizes in a list of dictionaries without commas

# need it to be an array of dictionaries - wrap all in []
jq '[.prizes[] | {year: .year | tonumber, prize: .category}]' NobelPrizes.json
> array with dictionaries for each year (as number) and prize

# Let's put the winners in first. Need to skip the organizations for now

# Need to build winners names with string interpolation
jq '[.prizes[] | .laureates[]? | "\(.firstname) \(.lastname)"]' NobelPrizes.json
> Array with each element a first and last name combined, but the last names are all null - should be surname, not lastname

jq '[.prizes[] | .laureates[]? | "\(.firstname) \(.surname)"]' NobelPrizes.json
> Array of names correctly formatted

# Let's pipe that to a file called pbs159-challenge.json
jq '[.prizes[] | .laureates[]? | "\(.firstname) \(.surname)"]' NobelPrizes.json > pbs159-challenge.json
> searched file for null and it found a bunch, like "Memorial null"

# before fixing, put prizes and year together with firstname surname
jq '[.prizes[] | {year: .year | tonumber, prize: .category} | .laureates[]? | "\(.firstname) \(.surname)"]' NobelPrizes.json
> empty array []. I think because all that's been passed to .laureates[]? is the year and prize

# maybe add a select any to .laureates and put it before year and prize
jq '[.prizes[] | select(any(.laureates[]?)) | {year: .year | tonumber, prize: .category} | "\(.firstname) \(.surname)"]' NobelPrizes.json
> error

# trying any laureates where .surname != null
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category}]' NobelPrizes.json
> Array of year and prize, not sure if it's any null prizes

# try to get names in there
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, "\(.firstname) \(.surname)"}]' NobelPrizes.json
> names became "null null": null

# forgot winners:
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, winners: "\(.firstname) \(.surname)"}]' NobelPrizes.json
> now it's "winners": "null null"

jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, | .laureates[] | winners: "\(.firstname) \(.surname)"}]' NobelPrizes.json
> jq: error: May need parentheses around object key expression at <top-level>

# remove pipe before .laureates[] and add parentheses
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, (.laureates[] | winners: "\(.firstname) \(.surname)")}]' NobelPrizes.json
> jq: error: syntax error, unexpected ')', expecting '}' - well make up your mind!

# Remove parentheses
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, .laureates[] | winners: "\(.firstname) \(.surname)"}]' NobelPrizes.json
> jq: error: May need parentheses around object key expression at <top-level>

# Maybe .laureates[] needs to be right before the fn/sn
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, winners: .laureates[] | "\(.firstname) \(.surname)"}]' NobelPrizes.json
> Got all 3 year, prize, and winners now but it's still got "winners": "Memorial null" in 2022 for example
{
    "year": 2022,
    "prize": "literature",
    "winners": "Annie Ernaux"
  },

# Have to figure out the nonexistent prizes but also the winners for a given year are supposed to be in a little array of their own
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> this put the winners in individual arrays but they aren't collected by prize
 {
    "year": 2022,
    "prize": "peace",
    "winners": [
      "Ales Bialiatski "
    ]
  },
  {
    "year": 2022,
    "prize": "peace",
    "winners": [
      "Memorial null"
    ]
  },

# try simplifying to get rid of null surnames:
jq '[.prizes[] | select(.laureates[]? | .surname != null)]' NobelPrizes.json
> thought it worked cuz no nulls, but it has prizes with no last names. :-(

# try using the previous syntax to not get null surnames - same results as above
jq '[.prizes[] | select(.laureates[]? | .surname != null) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> still get null as non-people last names

# maybe select laureates who's surnames aren't null needs to be where .laureates[] is in winners
jq '[.prizes[] | {year: .year | tonumber, prize: .category, winners: select(.laureates[]? | .surname != null) | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> "winners: "null null"

# try to just get the laureates who have a surname
jq '.prizes[] | .laureates[]? | .surname != null' NobelPrizes.json > people.json
> long list of "true"

# maybe use the all function?
jq '.prizes[] | .laureates[]? | all(.surname != null)' NobelPrizes.json > people.json
> jq: error (at NobelPrizes.json:0): Cannot index string with string "surname"

# need to ask something after true
jq '.prizes[] | .laureates[]? | .surname != null | .winners' NobelPrizes.json > people.json
> Cannot index boolean with string "winners"

# Forget fixing null surnames for now. try to make winners in an array
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, [winners: .laureates[] | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error: syntax error, unexpected '['

# try to get # winners
jq '.prizes[] | {numWinners: .laureates | length}' NobelPrizes.json
> this may have worked?
{
  "numWinners": 3
}
{
  "numWinners": 1
}
{
  "numWinners": 1
}
{
  "numWinners": 1
}
{
  "numWinners": 2
}

# try to add year and category
jq '[.prizes[] | {year: .year | tonumber, prize: .category, numWinners: .laureates | length}]' NobelPrizes.json
> success (verified .prizes[-2]
{
    "year": 1901,
    "prize": "peace",
    "numWinners": 2
  },
  {
    "year": 1901,
    "prize": "physics",
    "numWinners": 1
  },
  {
    "year": 1901,
    "prize": "medicine",
    "numWinners": 1
  }
]

# add the winners themselves in
jq '[.prizes[] | {year: .year | tonumber, prize: .category, numWinners: .laureates | length, winners: [.laureates]}]' NobelPrizes.json
> too much data in .laureates. need fn and sn 

# try put fn/sn in last element of array
jq '[.prizes[] | {year: .year | tonumber, prize: .category, numWinners: .laureates | length, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error (at NobelPrizes.json:0): Cannot iterate over null (null)
> Why on this one but not the one above or the one to beat? both of them work

# simplify again
jq '.prizes[] | {numWinners: .laureates | length, .laureates[] | "\(.firstname) \(.surname)"}' NobelPrizes.json
> jq: error: syntax error, unexpected FIELD (Unix shell quoting issues?) at <top-level>, line 1:

# asked chatGPT on a simple file how to return .firstname only if there is a .surname
.laureates[] | select(.surname) | .firstname

jq '[.prizes[] | .laureates[]? | select(.surname) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> null (null) cannot be parsed as a number

# Try it without the stuff above laureates
jq '[.prizes[] | .laureates[]? | select(.surname) | {winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> Cannot iterate over null (null)

# example from pbs 157
jq '.prizes[] | .year, .category, (.laureates[]? | .surname)' NobelPrizes.json
jq '[.prizes[] | {.year: .year | tonumber, prize: .category, winners: .laureates[]?}]' NobelPrizes.json

# the order looks wrong to select laureates first
jq '[.prizes[] |  {year: .year | tonumber, prize: .category, .laureates[]? | select(.surname) | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> error: syntax error, unexpected '(', expecting '}'

# Asked ChatGPT skip dictionaries in array missing specific key
.[] | select(has("key")) **NOTE: key isn't .key, it's just the word**
jq '[.prizes[] | .laureates[]? | select(has("surname"))]' NobelPrizes.json
> This works to eliminate those dictionaries that have no surname entries!

# use select(has("key")) in the one to beat
jq '[.prizes[] | {year: .year | tonumber, prize: .category, winners: (.laureates[]? | select(has("surname")) | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error: syntax error, unexpected INVALID_CHARACTER (Unix shell quoting issues?)

# Rearrange the deck chairs
jq '[.prizes[] | .laureates[]? | select(has("surname")) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error (at NobelPrizes.json:0): null (null) cannot be parsed as a number

# combine select and has more like pbs157 challenge solution
jq '[.prizes[] | select(any(.laureates[]?; (has("surname"))) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error: syntax error, unexpected INVALID_CHARACTER expecting ';' or ')'

# simplify to see if I can find error
jq '[.prizes[] | select(any(.laureates[]?; (has("surname")))]' NobelPrizes.json
> jq: error: syntax error, unexpected INVALID_CHARACTER expecting ';' or ')'

#
jq '[.prizes[] | select(has("surname")]' NobelPrizes.json
> jq: error: syntax error, unexpected INVALID_CHARACTER, expecting ';' or ')'

# Can I check length of surname when it's not even there?
jq '[.prizes[] | select(any(.laureates[]?; | (.surname | length != null))) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error: syntax error, unexpected '|' (Unix shell quoting issues?)

# maybe it's type != null
jq '[.prizes[] | select(.laureates[].surname | type != null) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json

# I GIVE UP ON NULL ENTRIES!

# try to count the surnames
jq '[.prizes[] | select(.laureates[]? | .surname != null) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> interesting. the count was correct but it caused there to be two dictionaries for each winner now

# moved square bracket to be after winners:
jq '[.prizes[] | select(.laureates[]? | .surname != null) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[] | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> w00t! got the winners into the same array now, but there are multiple copies of the same dictionary based on the number of winners. so if 3 winners, there's 3 copies of the dictionary. If one of the winners is not a person, so no surname, they're still in here but those dictionaries are NOT replicated.

{
    "year": 1901,
    "prize": "peace",
    "numWinners": 2,
    "winners": [
      "Henry Dunant",
      "Frédéric Passy"
    ]
  },
  {
    "year": 1901,
    "prize": "peace",
    "numWinners": 2,
    "winners": [
      "Henry Dunant",
      "Frédéric Passy"
    ]
  },
  
  But only one for:
  {
    "year": 2007,
    "prize": "peace",
    "numWinners": 2,
    "winners": [
      "Intergovernmental Panel on Climate Change null",
      "Al Gore"
    ]
},

# try again to remove null
jq '[.prizes[] | .laureates[]? | select(has("surname")) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[] | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> null (null) cannot be parsed as a number

# try without messing with surname existence
jq '[.prizes[] | .laureates[]? | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[] | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> null (null) cannot be parsed as a number
> so that .surname != null is doing SOMETHING but it's not doing what I want it to do

# working with simplified version called 2.json in ChatGPT folder
jq '.prizes[] | .laureates[]? | select(has(surname))' NobelPrizes.json
> surname/0 is not defined at <top-level>

jq '.prizes[] | select(any(surname(.laureates[]?)))' 2.json
> surname/1 is not defined at <top-level>

jq '.prizes[] | select(any(.laureates[]?; has(surname)))' 2.json
> surname/0 is not defined at <top-level>

=== bart ===

# don't try to filter out null surnames, those are still valid just erase (trim right) the word null
jq '[.prizes[] | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | "\(.firstname) \(.surname)" | rtrimstr(" null")]}]' NobelPrizes.json
> no duplicates, format is good, but the non-laureate non-prizes are still there

*****************
# SUCCESS!
*****************
# get rid of non-laureates by selecting the prizes that do have laureates using what I learned from ChatGPT
jq '[.prizes[] | select(has("laureates")) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | "\(.firstname) \(.surname)" | rtrimstr(" null")]}]' NobelPrizes.json
>  winner winner chicken dinner

======================================================================================================
# this WAS the one to beat (still has nulls & winners aren't in the same array)
jq '[.prizes[] | select(.laureates[]? | .surname != null) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
<!--{
    "year": 1901,
    "prize": "physics",
    "winners": [
      "Wilhelm Conrad Röntgen"
    ]
  },
  {
    "year": 1901,
    "prize": "medicine",
    "winners": [
      "Emil von Behring"
    ]
  }
]-->

# suggestion from chatGPT
jq '.laureates[] | select(.surname) | .firstname' file.json

===========BONUS CREDIT===================
**Purely for bonus credit**, you can avoid the need to trim the space from the end of organisational winners by ensuring it never gets added. One way to achieve this is to combine the following jq functions and operators:

1. The alternate operator (`//`)
2. The `empty` function — we've not seen it yet, but it takes no arguments and returns absolute nothingness
3. The `join` function

Note that `["Bob", "Dylan"] | join(" ")` results in `"Bob Dylan"`, but `["Bob"] | join(" ")` results in just `"Bob"`.

# translation to my situation
# I had to remove " null" so I'll try to to use `empty`

# Starting point - my successful query for part one:
jq '[.prizes[] | select(has("laureates")) | {year: .year | tonumber, prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | "\(.firstname) \(.surname)" | rtrimstr(" null")]}]' NobelPrizes.json

# in sentence form
* if laureate doesn't have a key for surname, then return just first name, otherwise return both

# try again to get just laureates who have a surname
jq '[.prizes[] | select(has("laureates")) | {winners: [.laureates[] | .laureates[]? | select (has("surname")) | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
>  {
    "winners": []
  },

# exploded .laureates twice
jq '[.prizes[] | select(has("laureates")) | {winners: [.laureates[]? | select (has("surname")) | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> worked! I think. 

# add in the rest of the glop from the working solution
jq '[.prizes[] | select(has("laureates")) | {year: (.year | tonumber), prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | select (has("surname")) | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> yes! now I can see Al Gore but not the thing without the surname. it says winners 2 since we count the winners before eliminating those without surname (so this isn't a perfect solution if I wanted to stop here

# Now how to put in the "or" with // to get the ones without a surname
jq '[.prizes[] | select(has("laureates")) | {year: (.year | tonumber), prize: .category, numWinners: (.laureates | length), winners: [.laureates[]? | (select (has("surname")) | "\(.firstname) \(.surname)") // "\(.firstname)"]}]' NobelPrizes.json
> WINNER WINNER CHICKEN DINNER!!!








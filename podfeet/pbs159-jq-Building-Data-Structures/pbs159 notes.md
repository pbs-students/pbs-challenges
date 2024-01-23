PBS 159 Challenge

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
> this worked - sent to a file and searched for null and it didn't find any. full prizes file

# try using the previous syntax to not get null surnames - same results as above
jq '[.prizes[] | select(.laureates[]? | .surname != null) | {year: .year | tonumber, prize: .category, winners: .laureates[] | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json

# maybe the select laureates who's surnames aren't null needs to be where .laureates[] is in winners
jq '[.prizes[] | {year: .year | tonumber, prize: .category, winners: select(.laureates[]? | .surname != null) | ["\(.firstname) \(.surname)"]}]' NobelPrizes.json
> "winners: "null null"

# Forget fixing null surnames for now. try to make winners in an array
jq '[.prizes[] | select(any(.laureates[]?; .surname != null)) | {year: .year | tonumber, prize: .category, [winners: .laureates[] | "\(.firstname) \(.surname)"]}]' NobelPrizes.json
> jq: error: syntax error, unexpected '['
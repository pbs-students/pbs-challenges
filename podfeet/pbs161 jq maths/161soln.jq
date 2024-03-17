# Write a jq script that will take as its input the Nobel Prizes data set (NobelPrizes.json) and sanitises it using the various assignment operators to achieve the following changes:

# Add a boolean key named awarded to every prize dictionary to indicate whether or not it was awarded.
  # 1943 no prize in literature or peace but was in physics, etc
  # Bart says it has a laureate if it was awarded
  # this finds those with laureates
  # jq '.prizes[] | select((.laureates | type) == "array")' NobelPrizes.json
  # jq '.[] += {awarded: "no"}' menu.json
  # added identical key/value to each dictionary entry
# close - this put it after the laureates array
# jq '.prizes[] | select((.laureates | type) == "array") += {awarded: "yes"}' NobelPrizes.json > deleteme.json
# close - this put it after each laureate and throws away unawarded prizes
jq '.prizes[] | select((.laureates | type) == "array") | .laureates[] += {awarded: "yes"}' NobelPrizes.json > deleteme.json

# We want it at the level of "laureates" and "year"
jq '.prizes[] 
  | if ((.laureates | type) == "array") 
  then .[] += {awarded: "yes"} 
  else .[] += {awarded: "no"}'  
  NobelPrizes.json > deleteme.json

# might be able to create two files and then smash them together but that seems inelegant.


# Ensure all prize dictionaries have a laureates array. It should be empty for prizes that were not awarded.
# Add a boolean key named organisation to each laureate dictionary, indicating whether or not the laureate is an organisation rather than a person.
# Add a key named displayName to each laureate dictionary. For people, it should contain their first & last names, and for organisations, just the organisation name.

[
  .prizes[]
]

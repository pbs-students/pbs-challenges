# Sanitises the Nobel Prizes data set as published by the Nobel Prize Committee
# Input:    JSON as published by the Nobel Committee
# Output:   the sanitised JSON, in particular
#   - add a boolean key named `awarded` to every prize dictionary,
#       to indicate whether or not it was awarded.
#   - ensure all prize dictionaries have a `laureates` array.
#       It should be empty for prizes that were not awarded.
#   - add a boolean key named `organisation` to each laureate dictionary,
#       indicating whether or not the laureate is an organisation rather than a person.
#   - add a key named `displayName` to each laureate dictionary. 
#       For people, it should contain their first & last names, 
#       and for organisations, just the organisation name.
#   - convert the year to number

[
    .prizes[]
    # the awarded prizes have a `laureates` key
    | .awarded = has("laureates")
    # for prizes not awarded, the laureates key is not present, so it would
    # return `null` when called. We either reassign it to itself if it is present,
    # or an empty array if it is `null` 
    | .laureates //= []
    # to identify organizations, we can check whether or not the laureate has
    # a surname. However, there are two edge cases, for people who only have
    # a first name, namely "Aung San Suu Kyi" and "Le Duc Tho"
    | .laureates[] |= (.organisation = ((has("surname") | not) 
        and (.firstname != "Aung San Suu Kyi")
        and (.firstname != "Le Duc Tho")))
    # create a new key `displayname` for each laureate, containing
    # both first name and surname (if the latter is present)
    | .laureates[] |= (.displayname = ([.firstname, (.surname // empty)] | join(" ")))
    | .year = (.year | tonumber)
] | @json
jq '.prizes | .laureates[] | sort_by(".surname")' previous.json new.json

# Cannot index array with string "laureates"

jq '.prizes[] | .laureates[]' previous.json new.json

# Cannot index array with string "prizes" - forgot the >!

jq '.prizes[] | .laureates[] | sort_by(".surname")' previous.json new.json

# array ([[".surname...) cannot be sorted, as they are not both arrays

jq '.prizes[] | select(.laureates | sort_by(".surname"))' previous.json new.json

# Cannot index array with string "prizes"

jq '.prizes[] | .laureates[]' previous.json > new.json
# didn't barf

jq '.prizes[] | select(.laureates | sort_by(".surname"))' previous.json > new.json
# didn't barf but it also didn't sort
# need to extract the laureates?

jq '.prizes[] | .laureates[] | sort_by(".surname")' previous.json > new.json
# array ([[".surname...) cannot be sorted, as they are not both arrays

jq '.prizes[] | .laureates[] | sort_by(.surname)' previous.json > new.json
# Cannot index string with string "surname"

jq '.prizes[] | sort_by(.laureates.surname)' previous.json > new.json
# Cannot index string with string "laureates"
jq '.prizes[] | sort_by(.surname)' previous.json > new.json
# Cannot index string with string "surname"

jq '.prizes[] | .laureates[] | sort_by(.surname)' previous.json > new.json
# your first example is three characters away from the right path
# a [
# a ]
# and a ?
# (not all prizes have laureates)

jq '.prizes[] | .laureates[] | [laureates.surname]' previous.json > new.json
# produced an array of nulls

# wrap in [] before sort
jq '[.prizes[] | .laureates[]] | .sort_by(.laureates)' previous.json > new.json
# compile error

jq '[.prizes[] | .laureates[]]' previous.json > new.json 
# gives an array of laureates

jq '[.prizes[] | .laureates[]] | .sort_by(.surname)' previous.json > new.json 
# unexpected '(', expecting end of file (Unix shell quoting issues?)

jq '[.prizes[] | .laureates[]] | (has("surname")) | sort_by(.surname)' previous.json > new.json 

jq '.[] | has("surname")' new.json 
# this returns a list of true and false
# So maybe I need to have a select on has("surname") so I keep the entries in the array

jq '.[] | select(has("surname"))' new.json
# that seems to work - but not an array

jq '[.[] | select(has("surname"))]' new.json
# Now it's an array

jq '[.[] | select(has("surname"))] | sort_by("surname")' new.json
# doesn't barf but they're not alphabetized

jq '[.[] | select(has("surname"))] | sort_by(.surname)' new.json > alpha.json
# I THINK THIS WORKED!
# so let's put the thing that greated new.json together with this
jq '[.prizes[] | .laureates[]]' previous.json > new.json jq '[.prizes[] | .laureates[]]' previous.json > new.json  
jq '[.[] | select(has("surname"))] | sort_by(.surname)' new.json > alpha.json

# WINNER WINNER CHICKEN DINNER!
jq '[.prizes[] | .laureates[] | select(has("surname"))] | sort_by(.surname)' previous.json > alpha.json


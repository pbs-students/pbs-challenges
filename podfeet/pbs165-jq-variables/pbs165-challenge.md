## An Optional Challenge

Starting with `pbs164-challengeSolution-Bonus.jq` (or your own bonus credit solution to the previous challenge), update the script to capture the details from every matched breach for every user. For each matching user+breach combination, return a **dictionary** indexed by:

1. `AccountName`: the user's email account name
2. `BreachName`: the name of the matching breach
3. `BreachTitle`: the title of the matching breach
4. `BreachedDataClasses`: the list of breached data classes

**Hint:** you'll need to explode the list of breaches for each user while retaining their account name in a variable.

For bonus credit, update the matching logic to check both the breach title and breach ID for a case-insensitive match against the search string. **Hint:** you'll need more parentheses and the `or` operator.

## My solution

something as $AccountName
* previous solution just has their account name as .key so I gotta save that or make it a key called AccountName
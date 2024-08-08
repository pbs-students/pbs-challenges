# Challenge

Write a jq filter that takes as an argument a search string, and filters a HIBP export down to just the users caught up on any breach that matches the search string. The search should be case-insensitive, so linkedin should match all three of the breaches at LinkedIn (from 2012, 2021 & 2023).

For bonus credit, update your filter to make use of the breaches data file from HIBP to ignore any breaches that did not expose passwords.

# My Approach

Have to have the breach in our demo data sate hibp-pbs.demo.json and since he mentioned LinkedIn, might as well use that.
<<<<<<< Updated upstream

# bonus

select(any(.value
=======
>>>>>>> Stashed changes

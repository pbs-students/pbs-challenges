#!/usr/bin/env bash
# get-show-id.sh
#
# Get the hyphenated show title which is an id attribute of the 2nd H1 element
# in the show .html page
# The output from this script can be used to mkdir a folder
# We curl the value of $1 which must be the complete of Bart's show page for that
# episode then pipe it into htmlq and get matching h1 with partial id="pbs-" ...
# Then get only the id attribute of that
curl --silent "https://pbs.bartificer.net/pbs${1}" | htmlq -a id 'h1[id^="pbs-"]' | sed -e 's/-of-x-//'

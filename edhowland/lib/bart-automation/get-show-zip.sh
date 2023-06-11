#!/usr/bin/env bash
# get-show-zip.sh : gets the shows .zip file from the github raw link
# Note: You must supply the current show number not the previous one like in
# get-show-id.sh

# create a tmp folder (must be in repo-root/bart)
mkdir -p tmp; cd tmp
wget "https://github.com/bartificer/programming-by-stealth/raw/master/instalmentZips/pbs${1}.zip"  && unzip "pbs${1}.zip" && cd "pbs${1}" && echo -e  "You should:\ncd tmp/pbs${1}\ndo your work then\ncd ../..\nWhen all done: rm -rf ./tmp"
echo exit code from above was: $?

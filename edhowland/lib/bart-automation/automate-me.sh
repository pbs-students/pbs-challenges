#!/usr/bin/env bash
# automate-me.sh : Steps to automate the creation of ./bart challenge  solutions
# 0. Ask for the previous PBS show number
# 1. Get the correct show number as a valid folder name
# 2. Calculate the next show notes .zip number from above
# 3. Download the zip file
#     * Note: this will also unzip the .zip folder into ./tmp/pbs{number}/
# 4. At this point the maintainer is asked to cd into that ./tmp/pbs{number}/ 
# * and do the work of grabbing only the challenge-solution .sh file, its
# * supplemental files, if needed
#  5. cp those files to ../../pbs-{number}-xxxxx 
# 6. cd to that folder
# 7.

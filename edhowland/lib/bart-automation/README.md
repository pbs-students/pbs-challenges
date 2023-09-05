# bart-automation : A place to store scripts for automating Bart's folder

## Abstract

Scripts in this folder can be used in preparation the creation of the folders
in Bart's folder. Those folders in <repo-root>/bart are show titles containing
the challenge solutions

## Manifest

- get-show-id.sh :  Used to get the hyphenated show title given a show number
  * Uses the 'sed' command to remove the "-of-x-" part
- get-show-zip.sh : Used to get theshow notes .zip containing Bart's solution
- automate-me.sh : Script to automate all the steps
  * Currently only incomplete list of comments detailing each step
  * Meant to be pseudo-code which will become real code in Bash someday


## Highlight: New Nushell automation

In the folder: ./nushell, you will find a more natural way of automating
the collection  of Bart's challenge solutions. See: [nushell/README.md](nushell/README.md)


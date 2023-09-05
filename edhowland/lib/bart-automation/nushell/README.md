# Nushell based automation

## Abstract

This folder is an attempt to make a better series of scripts written in Nushell:
[https://www.nushell.sh](https://www.nushell.sh)

## Installing Nushell

### MacOS

```bash
brew install nushell
```

After installing Nushell with Homebrew, you must register the 'nu_plugin_query'
with the following command in Nushell itself:

```bash
nu
register 
register /opt/homebrew/bin/nu_plugin_query
```

This ensures that Nushell can do web scraping that we need to do with Bart's
show notes page.

## Other operating systems

See the install guide on the Nushell GitHub page:


[https://github.com/nushell/nushell](https://github.com/nushell/nushell)


Go to the "Installation" heading.


## Installing with Rust toolchain:   cargo


## What is here

### Configuration

There are several edge cases we have to deal with whenever it comes to web
scraping which is what this project is aiming to do. We store all of the
 majick strings in the ./load_config.nu file.

As of this writing, the current show number is 153 and the  load_config.nu is
current with those expectations.


Note: the possible changing keys and values are:

-   solution_suffix: "challengeSolution.sh", # could be challengeSolution.js
-   challenge_heading_level: "h2", # In some older challenges was h3


Both of these values can be changed with flags to the './automate.nu' script. See below.

### The ./automate.nu script

Parameters: The episode number of the current show of Programming by Stealth

Must be the current show number not the previous show number wich is calculated
from the current show number. We need to get the .zip from the current show's resource page.
For all other uses, we need the HTML from the previous show notes page.

#### Flags

- '-h, --help' : Gets help on automate.nu
- '-s, --suffix' :   Overrides the solution_suffix  used to find the correct solution file in the extracted .zip file.
- '-l, --heading' : Overrides the heading level for thechallenge text in the previous show notes

Note: Since,  as of PBS 154, we are finished with the miniseries on
Bash programming. This probably means the challenge solutions file name
is going to change from '
"pbsN-challengeSolution.sh". Where the 'N' is something like 152.
Editing the config: 'load_config.nu'. is one way to change this going forward.
You can temporarily change it with the '--suffix' flag to './automate.nu' script.

Note: Over time,  the show notes have placed the  challenge text in a
'<p> ... </p>' tag following  either  an '<h2>' or '<h3'> tag.  This value
is configured in 'load_config.nu' in the  '$automate_config.challenge_heading_level'
variable.  It is set to 'h2' which  is current as of PBS 153. It can be overridden
via the '--heading' flag to './automate.nu --heading h3 152', for example.



#### Operation

The automate script performs the following steps:

1. Checks to make sure the Nushell query plugin is installed and registered
2. Downloads the current show number's .zip file into the file current.zip
3. Unzips this file
4. Downloads the previous show episode HTML into previous.html
5. Gets the show title from previous.html. A hyphenated  string
6. Creates a directory in the (gitroot)/bart folder named fro the show title
7. Copies the solution file from the  extracted .zip folder into the above folder
8.  Extracts the text of the challenge which is either a h2 or h3 tag of previous.html
  * Based on the CSS selector in load_config.nu
9. Updates the text of the (gitroot)/bart/readme.md with a h2 <show-title>
  * and the text extracted above
10. Prompts the user on future steps
  * Check for additional scripts/data files in current.zip extracted folder
  * and possibly copy them to (gitroot)/bart/pbs-n-<show-title>/
  * do a git add of (gitroot)/bart
  * clean up the files:

1. current.zip
2. pbs<N>/ : E.g. ./pbs153/
3. previous.html

Finally:

11.   git commit with message for the challenge solution name and show number
12. git tag with show number and Bart's challenge solution

### Modules

Nushell modules used by ./automate.nu

Example of using Nu modules. Say we want the show title

```sh
let title = (open previous.html | webq show id | format show title)
```



#### config

This module handles configuration settings. By doing nothing but running
the './automate.nu <current-show-number>' you get all the settings in
'load_config.nu'. But by passing flags to './automate.nu <flags> <current-show-number>',
some of these values can be changed. The config module is responsible  for setting these options.

- set heading <heading-level> : Change the value of the key .challenge_heading_level

Additional  commands for troubleshooting

- heading : Prints the current value of .challenge_heading_level
- suffix : Prints the value of .solution_suffix
- reset : Resets all values of all keys to the values in the file: 'load_config.nu'

- set suffix <suffix> : Change the  value of the key .solution_suffix

#### format

This Nushell module located in ./format/ contains

1. zip url : the direct URL of the resources .zip file for the current show
- show title : Takes a string like: pbs-153-of-X--bash-... and strips off the first




#### webq

this Nushell module in ./webq extracts content from passed in previous.html



- show id :  extracts the id addtibute of the second h1 on the show page- show challenge
- show challenge : Extracts the page  text for the heading of bounus challenge

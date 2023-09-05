# This is Bart's folder

## Layout of this document

Every section below is a folder name in reverse order of the episode number
(whith the exception of the most recent episode). 

Every section contains:

- The folder name for that episode
  * E.g. ## pbs-146-bash-shell-loops/
- Bart's description of the challenge
  * And any possible bonus challenges
- A link to the episode page on the PBS web site for the show notes
  * E.g. https://pbs.bartificer.net/pbs146

### A note on running the challenge solutions

Bart has helpfully named every solution  script with the following format:
 'pbs1XX-challenge-solution.sh' - where the pbs1XX is the  episode number.
E.g. in the folder pbs-148-bash-potpourri is the file:  
pbs148-challenge-solution.sh
It can be run thusly:

```bash
$ cd  pbs-148-bash-potpourri
$ ./pbs148-challenge-solution.sh
```

Sometimes there are supplemental files like: 'menu.txt' and bonus challenge 
solution scripts. And in some cases there are options and arguments  and ways 
topipe content into the solution script.
See the show notes for further instructions.
Please contact any of us if you have any questions. If you comment on GitHub I
will see it and respond there.  You can contact me directly at:
ed.howland@gmail.com
Or ping me on Slack. I appear to be @edhowland there.
Or send me a toot on Mastodon. I am @edhowland@fosstodon.org




##### Index of all the Programming by Stealth episode show notes

[https://pbs.bartificer.net](https://pbs.bartificer.net)



##### Challenges are below this line

## pbs-153-bash-functions--scope

Finally, if you’d like to put your new-found function writing skills to the 
test, update your multiplication table script to replace duplicated code blocks 
with functions.

[PBS 153 show notes](https://pbs.bartificer.net/pbs153)


## pbs-153-bash-functions--scope

Finally, if you’d like to put your new-found function writing skills to the 
test, update your multiplication table script to replace duplicated code blocks 
with functions.

[PBS 153 show notes](https://pbs.bartificer.net/pbs153)


## pbs-152-bash-xargs--easier-arithmetic

Update your solution to the  pbs 151  challenge to make use of arithmetic
expressions for all your calculations. Also re-evaluate your code to see if there
are any places where using xargs could simplify your code.

[PBS 152 Show notes](https://pbs.bartificer.net/pbs152)


## pbs-151-bash-printf-and-more

Write a script to render multiplication tables in a nicely formatted table. Your script should:

    Require one argument  the number to render the table for
    Default to multiplying the number given by 1 to 10 inclusive
    Accept the following two optional arguments:
        -m to specify a minimum value, replacing the default of 1
        -M to specify a maximum value, replacing the default of 10

For bonus credit, pipe the output through less if and only if standard out is a terminal.


[PBS 151 Show notes](https://pbs.bartificer.net/pbs151)

##  pbs-150-of-x--bash-script-plumbing

Update your challenge solution from last time so it can ingest its menu in three ways:

Default to reading the menu from a file named menu.txt in the same folder as the script.
Read the menu from STDIN with the optional argument -m -.
Read the menu from a file with the optional argument -m path_to_file.txt
Regardless of where the menu is coming from, always present the menu interactively, i.e., the user always has to choose using the keyboard.

Finally, to simplify your script, feel free to remove the -s (snark) flag added last time.

Heres my sample solution, which youll find in this folder

[PBS 150 Show notes](https://pbs.bartificer.net/pbs150)

## pbs-149-bash-better-arguments-with-POSIX-special-variables/

In the meantime, if you want some more Bash practice, update your solution to the previous challenge to convert the optional argument for specifying a limit to a -l optional argument, and add a -s flag to enable snarky output (like the infamous Carrot weather app for iOS does).

-l LIMIT where LIMIT is the maximum number of items that can be ordered, which must be a whole number greater than or equal to one.
-s to request some snark.

Heres my sample solution, which youll find in this folder

[PBS 149 Show notes](https://pbs.bartificer.net/pbs149)


## pbs-148-bash-potpourri/

In the meantime, if you want some more Bash practice, update your solution to the challenge to accept an optional argument limiting the number of items a user can order from the breakfast menu.

You will find my solution in this folder.

[PBS 148 Show Notes](https://pbs.bartificer.net/pbs148)

## pbs-147-bash-arrays/

Write a script to take the users breakfast order.

The script should store the menu items in an array, then use a select loop to to present the user with the menu, plus an extra option to indicate theyre done ordering. Each time the user selects an item, append it to an array representing their order. When the user is done adding items, print their order.

For bonus credit, update your script to load the menu into an array from a text file containing one menu item per line, ignoring empty lines and lines starting with a # symbol.

My solution can be found in this folder.

[PBS 147 Show Notes](https://pbs.bartificer.net/pbs147)


## pbs-146-bash-shell-loops/

An Optional Challenge
If you'd like to put your Bash skills to the test, try writing a script that accepts a a whole number as an input, either as the first argument or from a user prompt, then prints out the standard n-times multiplication tables to the screen, i.e., if you give the number 3, the output should be:

1 x 3 = 3
2 x 3 = 6
3 x 3 = 9
4 x 3 = 12
5 x 3 = 15
6 x 3 = 18
7 x 3 = 21
8 x 3 = 24
9 x 3 = 27
10 x 3 = 30
You should use the bc (basic calculator) terminal command to do the arithmetic. Youll need to teach yourself how to use it either with the help of your favourite search engine, or the man page (man bc).

For bonus credit, update your script to allow the user to specify how high the table should go, defaulting to 10 like above.


My solution can be found in this folder.
[PBS 146 Show Notes](https://pbs.bartificer.net/pbs146)

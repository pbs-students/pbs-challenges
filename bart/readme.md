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

[The Programming By Stealth About page](https://pbs.bartificer.net)

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

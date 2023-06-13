# PBS 151: Print multiplication table

## Abstract

We are asked to modify our homework from PBS 146 where we used a loop to print
the multiplication table for a given multiplicand.

The program multi-table.sh
 is used to print a multiplication table given a positive whole number as a 
parameter or it will be prompted from the user.

## Usage

```bash
./multi-table.sh 9
```

## Options

The program will by default use the minimum of 1 and the maximum of 10 for the multipliers
but can be changed with the following options:

- '-m minimum' : Use minimum instead of 1
  * Must be a positive whole number
- '-M maximum' : Use maximum instead of 10
  * Must be a positive whole number



## Notes:

If the required parameter is missing or is not a positive whole number,
then the user will be prompted to enter a positive whole number greater than 0
continuously. The user can press Control plus C to exit this loop.

All 3 possible inputs (min, max and number) are checked to be a positive
whole number greater than 0. If the minimum or maximum are not whole numbers 
then the program reports an error message and then prints the usage string
and exits with a non-zero exit code.

## Bonus credit

If your output would go to a terminal, then pipe the output to the 'less' program
like 'git log' does. Else do not, say lke redirection to a file.


### Changes to the requirements from Bart

The name of the 'less' program comes from the phrase: 'less is more'. Because the
'more' program was the original pager program on Unix systems. Less improved
things by allowing paging backwards in the content. #UnixHumor

By convention, the $PAGER environment can be used to contravene the default
program  that is used to page content even when the output is to a terminal.
The multi-table.sh program honors the value of the $PAGER variable if set,
but only does so if the output would scroll a terminal based on the number
of lines on the terminal. E.g. if max - min >=  $LINES
But we cannot get the value of $LINES from within a shell script because it is
not exported to subshells. So, we compute it with the 'stty size' command.

```bbash
sttt size
23 80
```


We also check if the stdout will go to the terminal
 with the 'test -t 1' command.
If so, then set the variable PAGER to the value of $PAGER and if not set
then default it to 'less'. Therefore, mult-table.sh honors the user's pager
preferences and also the current size of the terminal.

## Testing

There are some scripts for testing things out


- test.sh : Used to test the library source 'die_unless.sh'
- pseudo-pager.sh : A fake pager like 'less' that does not page

If you pipe any output into pseudo-pager.sh, it will just surround the first
and last line with 'start ===== / end =====' lines.
Then you can use this in your PAGER variable to check if the output is being

 

piped into $PAGER.

E.g.

```bash
export PAGER=${PWD}/pseudo-pager.sh
./multi-table.sh -M 50 5
```

And then test its output when redirected to a file:

```bash
./multi-table.sh -M 50 5 > 5xtimes.txt
```

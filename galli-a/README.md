# Programming By Stealth - Challenges solutions

This folder contains my solutions to the challanges in the instalments for the [Programming By Stealth podcast](https://pbs.bartificer.net), starting from episode 146

## [Episode 146 of X — Bash: Shell Loops](https://pbs.bartificer.net/pbs146)

### Optional challenge

If you’d like to put your Bash skills to the test, try writing a script that accepts a a whole number as an input, either as the first argument or from a user prompt, then prints out the standard n-times multiplication tables to the screen, i.e., if you give the number 3, the output should be:

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

You should use the bc (basic calculator) terminal command to do the arithmetic. You’ll need to teach yourself how to use it either with the help of your favourite search engine, or the man page (man bc).

For bonus credit, update your script to allow the user to specify how high the table should go, defaulting to 10 like above.

### Solution

The solution is in the file `pbs146-challenge_solution.sh`. To test it, call it with a single argument (which has to be a positive integer number), like this:

	./pbs146-challenge_solution.sh 3

which will have the requested output:

	1 × 3 = 3
	2 × 3 = 6
	3 × 3 = 9
	4 × 3 = 12
	5 × 3 = 15
	6 × 3 = 18
	7 × 3 = 21
	8 × 3 = 24
	9 × 3 = 27
	10 × 3 = 30

Adding a second argument (again a positive integer number) will change the upper limit of the table:

	./pbs146-challenge_solution.sh 3 5

<!-- -->

	1 × 3 = 3
	2 × 3 = 6
	3 × 3 = 9
	4 × 3 = 12
	5 × 3 = 15


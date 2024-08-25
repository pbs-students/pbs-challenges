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

## [Episode 147 of X — Bash: Arrays](https://pbs.bartificer.net/pbs147)

### Optional challange

Write a script to take the user’s breakfast order.

The script should store the menu items in an array, then use a `select` loop to to present the user with the menu, plus an extra option to indicate they’re done ordering. Each time the user selects an item, append it to an array representing their order. When the user is done adding items, print their order.

For bonus credit, update your script to load the menu into an array from a text file containing one menu item per line, ignoring empty lines and lines starting with a `#` symbol.

### Solution

The solution is in the file `pbs147-challenge_solution.sh`. Went directly for the bonus credit version, so alongside the script there is also the menu definition text file `breakfast_menu.txt`.

The main difficulty was in filling the global array variable from the `while` loop, so used process redirection (`<()`) and an input redirection (`<`) at the end of the loop, like this.

	while read -r line
	do
		# ...
	done < <(cat $menu_filename)

Credit to [this answer](https://askubuntu.com/questions/678915/whats-the-difference-between-and-in-bash) on StackOverflow.


## [Episode 148 of X — Bash: Potpourri (Subshells, Relative Paths & More)](https://pbs.bartificer.net/pbs148)

### Optional Challenge

Update the breakfast menu script to it can optionally accept an argument — a limit on the number of items you can order.

### Solution

The solution is in the file `pbs148-challenge_solution.sh`.

## [Episode 149 of X — Bash: Better Arguments with POSIX Special Variables and Options](https://pbs.bartificer.net/pbs149)

### Optional Challenge

Update the breakfast menu script so it accepts two options:

1) `-l LIMIT` where `LIMIT` is the maximum number of items that can be ordered, which must be a whole number greater than or equal to one
2) `-s` to request some snark

### Solution

Not a native speaker, so not sure how to handle "snark" in messages...

## [Episode 150 of X — Bash: Better Arguments with POSIX Special Variables and Options](https://pbs.bartificer.net/pbs150)

### Optional Challenge

Update your challenge solution from last time so it can ingest its menu in three ways:

1) Default to reading the menu from a file named `menu.txt` in the same folder as the script.
2) Read the menu from `STDIN` with the optional argument `-m -`.
3) Read the menu from a file with the optional argument `-m path_to_file.txt`

Regardless of where the menu is coming from, always present the menu interactively, i.e., the user always has to choose using the keyboard.

### Solution

The solution is in the file `pbs150-challenge_solution.sh`.

It can be used in several ways, apart from the `-s` flag and `-l` option from last episode.

By default reads from `menu.txt`, so running:

	./pbs150-challenge_solution.sh

will duse that file as a source.

By running:

	./pbs150-challenge_solution.sh -m breakfast_menu.txt

another file will be used.

Finally, it can be called passing a list of items:

	echo "coffee\ntea\norange juice" | ./pbs150-challenge_solution.sh -m -

and it will use those as source.

In all cases, it is possible to redirect the final output to a file:

	echo "coffee\ntea\norange juice" | ./pbs150-challenge_solution.sh -m - > order.txt

while, at the same time, using the terminal for interaction with user.

## [Episode 151 of X — Bash: Printf and More](https://pbs.bartificer.net/pbs151)

### Optional Challenge

Write a script to render multiplication tables in a nicely formatted table. Your script should:

1) Require one argument — the number to render the table for
2) Default to multiplying the number given by 1 to 10 inclusive
3) Accept the following two optional arguments:
	* `-m` to specify a minimum value, replacing the default of 1
	* `-M` to specify a maximum value, replacing the default of 10

### Solution

The solution is in the file `pbs151-challenge_solution.sh`.

There are two points of attention. The first one is the management of the ouput. I added a threshold to the maximum number of lines to be displayed before moving to the pager, but this is hard-coded in the script:

	MAX_LINES_NO_PAGER=10

At the end of the script, I check for both redirection and number of lines, so that I can pipe to the pager or not:

	# check number of lines in output
	num_output_lines=$(printf "%s" "$output_string" | wc -l | xargs)
	if [[ $num_output_lines -gt $MAX_LINES_NO_PAGER ]] && [[ -t 1 ]]
	then
		# for output longer than limit, pipe to pager
		printf "%s" "$output_string" | less
	else
		# for shorter output, or if we are not redirecting, print directly
		printf "%s" "$output_string"
	fi

Not really satisfactory, will have to look for a better way.

The other point is much more subtle: the script uses the first non-optional arguments as the base number for the multiplication table. It also uses `getopts` to handle the optional arguments. If a negative number is passed, it will be intercepted by `getopts`, since it starts with a `-`, and will be treated as a non-valid option. For now, only positive numbers are accepted as valid inputs.

Another caveat: having my locale set to Italian, I do not have by default the thousands separator. So despite having the script account for them, I don't see them in the result unless I set a different locale when running the script.

Running

	./pbs151-challenge_solution.sh -m -1 -M 5 1000

outputs

	1000 x -1 = -1000
	1000 x  0 =     0
	1000 x  1 =  1000
	1000 x  2 =  2000
	1000 x  3 =  3000
	1000 x  4 =  4000
	1000 x  5 =  5000

while running

	env LC_ALL=en_US.UTF-8 ./pbs151-challenge_solution.sh -m -1 -M 5 1000

outputs

	1,000 x -1 = -1,000
	1,000 x  0 =      0
	1,000 x  1 =  1,000
	1,000 x  2 =  2,000
	1,000 x  3 =  3,000
	1,000 x  4 =  4,000
	1,000 x  5 =  5,000

## [Episode 152 of X — Bash: `xargs` & Easier Arithmetic](https://pbs.bartificer.net/pbs152)

### Optional Challenge

Update your solution to the PBS 151 challenge to make use of arithmetic expressions for all your calculations. Also re-evaluate your code to see if there are any places where using `xargs` could simplify your code.

### Solution

The solution is in the file `pbs152-challenge_solution.sh`.

Apart from copying Bart's handling of the pager options, the only improvement is the handling of negative values for the input, left as a drawback in the previous solution. In fact, argumetns starting with a `-` *can* be used, provided that they are preceded by the `--` flag, which signals to `getopts` to stop processing flags. This is actually a standard feature fo many terminal commands.

So changed my solution to also accept negative number in the regex.

So, in the base case running

	./pbs152-challenge_solution.sh 2

outputs

	2 x  1 =  2
	2 x  2 =  4
	2 x  3 =  6
	2 x  4 =  8
	2 x  5 = 10
	2 x  6 = 12
	2 x  7 = 14
	2 x  8 = 16
	2 x  9 = 18
	2 x 10 = 20

but

	./pbs152-challenge_solution.sh -2

results in an error:

	Usage: pbs152-challenge_solution.sh [-s START_VALUE] [-e END_VALUE] -- base_number

which can be solved using the `--` flag:

	./pbs152-challenge_solution.sh -- -2

<!-- -->

	-2 x  1 =  -2
	-2 x  2 =  -4
	-2 x  3 =  -6
	-2 x  4 =  -8
	-2 x  5 = -10
	-2 x  6 = -12
	-2 x  7 = -14
	-2 x  8 = -16
	-2 x  9 = -18
	-2 x 10 = -20

and, of course, the `-s` and `-e` optional parameters are retained:

	./pbs152-challenge_solution.sh -s -3 -e 12 -- -2

<!-- -->

	-2 x -3 =   6
	-2 x -2 =   4
	-2 x -1 =   2
	-2 x  0 =   0
	-2 x  1 =  -2
	-2 x  2 =  -4
	-2 x  3 =  -6
	-2 x  4 =  -8
	-2 x  5 = -10
	-2 x  6 = -12
	-2 x  7 = -14
	-2 x  8 = -16
	-2 x  9 = -18
	-2 x 10 = -20
	-2 x 11 = -22
	-2 x 12 = -24

The other main difference with respect to Bart's solution is in how the maximum field length for multiplier and result are determined. Since we are using `seq` to create the array of multipliers, and we are only using integer numbers, it is *guaranteed* that largest number, for both multiplier and result, will be in correspondance to one the minimum or maximum values for the multiplier, since either of them can be negative. Therefore, instead of looping through all the sequence to find the widest fieeld, and then looping once again to calculate the results and create the table, I calculate the field width only for the two extremes, and take the maximum as appropriate.

I also kept the possibility of piping from `STDIN`, just in case.

	echo 2 | ./pbs152-challenge_solution.sh

results in

	2 x  1 =  2
	2 x  2 =  4
	2 x  3 =  6
	2 x  4 =  8
	2 x  5 = 10
	2 x  6 = 12
	2 x  7 = 14
	2 x  8 = 16
	2 x  9 = 18
	2 x 10 = 20

and  interestingly,

	echo -2 | ./pbs152-challenge_solution.sh

works as expected, even without specifying the `--` flag

	-2 x  1 =  -2
	-2 x  2 =  -4
	-2 x  3 =  -6
	-2 x  4 =  -8
	-2 x  5 = -10
	-2 x  6 = -12
	-2 x  7 = -14
	-2 x  8 = -16
	-2 x  9 = -18
	-2 x 10 = -20

although it is not clear to me why that is.

## [Episode 153 of X — Bash: `xargs` & Easier Arithmetic](https://pbs.bartificer.net/pbs153)

### Optional Challenge

Finally, if you’d like to put your new-found function writing skills to the test, update your multiplication table script to replace duplicated code blocks with functions.

### Solution

The solution is in the file `pbs153-challenge_solution.sh`.

I created three functions, saved in the file `utility_functions.sh`.

The first function is called `is_integer_number`, and is used to check whether a single input is an integer number (either positive or negative) or not. In this case, only the first input is considered, and all others inputs are discarded. The function can accept either an argument, or a value from `STDIN`, and does not have any flags.

The second function is called `is_number`, and is similar to the first one, except that it accepts non-integer numbers, i.e. with a decimal part, again either positive or negative.

The third function is called `find_max`, and is used to identify the maximum value among all the input arguments, discarding those that are not numbers. Uses `is_number` to detect valid arguments, and accepts a flag to display warnings for any non-valid arguments.

## [Episode 157 of X — Bash: jq: Querying JSON with `jq`](https://pbs.bartificer.net/pbs157)

### Optional Challenge

Can you develop `jq` commands to answer the following questions:

1. What prize did friend of the NosillaCast podcast Dr. Andrea Ghez win? List the year, category, and motivation.
2. How many laureates were there for each prize? List the year, category, and number of winners for each.
3. Which prizes were won outright, i.e. not shared? List the year, category, first name, last name, and motivation for each.

### Solution

For each of the questions, there is a separate `bash` script, with name reflecting the question number:

- `pbs147-challange_solution_01.sh`
- `pbs147-challange_solution_02.sh`
- `pbs147-challange_solution_03.sh`

Adding a short explanation on how the solutions work.

#### Question 1

    jq '.prizes[] |
    	select(any(.laureates[]?; .firstname == "Andrea" and .surname == "Ghez")) |
    	(.year, .category, (.laureates[]? | select(.firstname == "Andrea" and .surname == "Ghez") | .motivation))' \
    	NobelPrizes.json

For this, started exploding the original array and piping each prize to a `select` function, where we iterate over the `laureates` array (with the `?` to skip zero-length arrays) and use a second input to the `any` function to select only the ones where the first name is "Andrea" surname is "Ghez". Having identified only the relevant prizes, we extract the information using three selectors. The first two are simple: `.year` and `.category`; for the third one, in order to get to the motivation, we need once again to select only the correct laureate, so we use a subgroup to filter the laureates with the correct first and last name, and extract the motivation from those. I used both first and last name in both filters just to make sure to not select any other "Ghez" that might be present.

The result is:

	"2020"
	"physics"
	"\"for the discovery of a supermassive compact object at the centre of our galaxy\""

#### Question 2

	jq '.prizes[] |
		select(any(.laureates; length > 0)) |
		(.year, .category, (.laureates | length))' \
		NobelPrizes.json

In this case, I decided to skip the cases where no prize was awarded, so I added a filter on the number of laureates to be greater than 0. After that it was a simple matter to add the requested outputs; as for the previous question, included a grouping for the third piece of information since it is in a sub-array, and this time it must not be exploded, since we want the length of the array of laureates itself, for each prize. The output is too long to be included here.

#### Queston 3

	jq '.prizes[] |
		select(any(.laureates; length == 1)) |
		(.year, .category, (.laureates[] | (.firstname, .surname, .motivation)))' \
		NobelPrizes.json

This is similar to the previous question in the initial filtering, just substituting the condition on the length of the laureates array to have the correct one. For the output, once again need to dig into a sub-array, so a grouping is needed. This time, however, we need information inside each element of the laureates array (even though we know the the array only has a single element), so we can use either `.laureates[]` or `.laureates[0]` with no difference in result. From that element, we extract the remaining information. Again, the output is too long to be included here.
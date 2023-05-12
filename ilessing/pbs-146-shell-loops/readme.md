### Episode 146 Shell Loops Challaenge:

write a shell script that accepts a a whole number as an input, either as the first argument or from a user prompt, then prints out the standard n-times multiplication tables to the screen, i.e., if you give the number 3, the output should be:

```
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
```

You should use the `bc` (basic calculator) terminal command to do the arithmetic. You’ll need to teach yourself how to use it either with the help of your favourite search engine, or the man page (man bc).

For bonus credit, update your script to allow the user to specify how high the table should go, defaulting to 10 like above.

- [show notes: for loops](https://pbs.bartificer.net/pbs146#for-loops)

## My Notes:

BB prefers looping over a range `{0..9}` 

```sh
for char in {0..9}
do
	echo $char
done
```

- [if statement - Difference between single and double square brackets in Bash - Stack Overflow](https://stackoverflow.com/questions/13542832/difference-between-single-and-double-square-brackets-in-bash)


2023-05-12: as an exercise I completed the challenge using Python instead of Bash. (see: `p-table_gen.py`)
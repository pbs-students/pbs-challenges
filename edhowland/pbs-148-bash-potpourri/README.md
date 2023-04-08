# pbs-148-bash-potpourri


## Abstract

This is my (Ed Howland) solution to Bart's PBS Challenge number 148

As I understand it,  the challenge is to present a menu of food items
and then use the Bash select statement to get the user's choice and finally 
print out all of their choices.

Since we are building on what we have already learned, we also need to use arrays
and reading from a file, although this is optional.

## My solution

The file: menu.sh runs the code and if there is no filename is present on the
command line it defaults to breakfast_menu.txt. 
Note: There is also lunch_menu.txt in this folder.

E.g.

```bash
./menu.sh
```



Or:

```bash
./menu.sh lunch_menu.txt
```


## Credits

I totally stole the menu files from ../../bill
And thanks to  Bart for enlightening me about here strings. Totally useful.

## Notes:

This is just the first attempt. There is no real user selection code yet.
We just get the filename, loop over its lines and stuff into the menu array.
I am using egrep to strip out the comments and blank lines from Bill's lists.
Then I  have just a test 'choices'  array. This will become an empty array
and then get the user choices.

### Bugs

Currently the first item in our list of menu items is listed as 0: pancakes
Not very user friendly. I wanted to use 0 to quit the selection bit.

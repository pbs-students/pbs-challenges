### [Episode 147](https://pbs.bartificer.net/pbs147) Arrays Challenge:

39:08 Write a script to take the user’s breakfast order.

The script should: 

- [x] store the menu items in an array, then 
- [x] use a `select` loop to to present the user with the menu items, 
- [x] an option to indicate user is done ordering. 
- [ ] Each time the user selects an item, append it to an array representing their order. 
- [ ] When the user is done adding items, print their order.

#### For bonus credit: 
-  update your script to load the menu into an array from a text file
  -  containing one menu item per line, 
  - ignoring empty lines and lines starting with a # symbol.
- @podfeet bonus: add bacon to the menu.  (allow special requests to the kitchen)

#### In this challenge we'll exercise:

- using the `select` loop
- arrays [menu, order]
- using the `read` command
- using the `cat` command
- ignore empty lines

I'm mentioned at 3:07 LOL

### My Notes

- [https://devhints.io/bash](https://devhints.io/bash) very helpful 
- examples at [shell tips](https://www.shell-tips.com/bash/select-loop/#gsc.tab=0) were also helpful
- run the script with `-x` flag to get some debug tracing output.  
example:

```sh
bash -x ilessing/pbs-147-bash-arrays/breakfast-order.sh
```

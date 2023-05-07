
## pbs-148-bash-potpourri/



In the meantime, if you want some more Bash practice, update your solution to the challenge to accept an optional argument limiting the number of items a user can order from the breakfast menu.

You will find my solution in this folder.

[PBS 148 Show Notes](https://pbs.bartificer.net/pbs148)

### To Dos

- [x] use `$BASH_SOURCE` environment variable
- [x] use `dirname` functions to derive correct paths
- [x] allow running the main script from some other directory
- [x] accept an argument
- [x] if agument is numeric treat it as item limit
- [x] break off ordering if limit specified on command line is reached

noticed that if one orders the same item more than once that still uses up the alloted choices.  Also if one orders every item on the menu that reaches your limit and you don't get to choose if you're done.  It's as if the waiter just decided not to accept any more menu choices from this customer.   I don't feel like programming around this edge case.

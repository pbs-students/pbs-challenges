# pbs150-plumbing-challenge

Response to challenge from Programming By Stealth installment 150 at 
[pbs.bartificer.net/...](https://pbs.bartificer.net/pbs149)

# ---------------------------------
Update your challenge solution from last time so it can optionally load the menu
from a or from STDIN. Add an option named -m (for menu), and if that option has 
the value -, read from STDIN, otherwise, treat the value of -m as a file path 
and load the menu from that file. If -m is not passed, default to reading from 
./menu.txt.

Also, make a conscious choice about what goes to STDOUT and STDERR.
# ---------------------------------

Example of usage:

```
./plumbing-challenge.sh -m -

Below is the breakfast menu.
Enter the number for the item you would like to order.
When you're done ordering, type 1 to select done and complete your order

1) done             4) Spam            7) More Bacon     10) Porridge
2) Pancakes         5) Bacon           8) Eggs
3) Waffles          6) Sausage         9) Eggs Benedict
#? 9
You added Eggs Benedict to your order

#? 10
You added Porridge to your order

#? 5
You added Bacon to your order

#? 7
You added More Bacon to your order


Your doctor says you're obese so you can't order any more food.
  
Let me read your order back to you:
* Eggs Benedict
* Porridge
* Bacon
* More Bacon
```
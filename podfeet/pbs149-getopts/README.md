# pbs149-getopts-challenge

Response to challenge from Programming By Stealth installment 149 at [pbs.bartificer.net/...](https://pbs.bartificer.net/pbs149)

# ---------------------------------
Update your solution to the previous challenge to convert the optional argument for specifying a limit to a -l optional argument, and add a -s flag to enable snarky output (like the infamous Carrot weather app for iOS does).

I'm also going to add error checking with getopts to see if the user chooses a number above or below the allowable range
# ---------------------------------

Example of usage:

```
./getopts-challenge.sh -s -l 4

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
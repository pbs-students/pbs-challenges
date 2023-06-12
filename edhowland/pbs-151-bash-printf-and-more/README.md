# Print multiplication table

## Abstract

The program multi-table.sh
 is used to print a multiplication table given a positive whole number as a 
parameter or it will be prompted from the user.

## Usage

```bash
./multi-table.sh 9
```

## Options

The program will by default use the minimum of 1 and the maximum multipliers
but can be changed with the following options:

- '-m minimum' : Use minimum instead of 1
  * Must be a positive whole number
- '-M maximum' : Use maximum instead of 10
  * Must be a positive whole number



## Notes:

If the required parameter is missing or is not a positive whole number,
then the user will be prompted to enter a positive whole number greater than 0
continously. The user can press Control plus C to exit this loop.

All 3 possible inputs (min, max and number) are checked to be a positive
whole number greater than 0. If the minimum or maximum are not whole numbers 
then the program reports an error message and then prints the usage string
and exits with a non-zero exit code.
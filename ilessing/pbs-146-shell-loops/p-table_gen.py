#! /usr/bin/env python3

# usage:
# table_gen [number [max number]]
#   generates a multiplication table for given [number]
#   defaults to ten rows.
#   if users provides a second argument it will be used 
#   as the number of rows in the table.

import sys

if len(sys.argv) > 1:
  users_number = int(sys.argv[1])
else:
  users_number = int(input('what number would you like a multiplication table for? '))

if len(sys.argv) > 2:
  users_max = int(sys.argv[2])
else:
  users_max = 10

multiplier = 0

print("\n")
while multiplier < users_max:
  multiplier += 1
  print(users_number , " times ", multiplier, " = ", users_number * multiplier)
print("\n")


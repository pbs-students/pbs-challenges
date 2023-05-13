#! /usr/bin/env ruby

# usage:
# table_gen [number [max number]]
#   generates a multiplication table for given [number]
#   defaults to ten rows.
#   if users provides a second argument it will be used 
#   as the number of rows in the table.

if ARGV.length == 0
# no command line arguments so we'll ask user for the multiplier
    puts("What number would you like to see multiplication table for?")
    multiplier = gets.chomp.to_i
    if multiplier == 0 
        puts(" you must enter a whole number. exiting") 
        exit 1
    end
    puts(" okay here we go with #{multiplier}")
elsif ARGV.length == 1
    # we have a command line argument 
    multiplier = ARGV[0].to_i
    if multiplier == 0 
        puts(" you must enter a whole number. exiting") 
        exit 1
    end
    puts("\n ok going with #{multiplier}\n")       
end

for i in (1..multiplier) do
    product = i * multiplier
  puts " #{i} times #{multiplier} = " + product.to_s
end
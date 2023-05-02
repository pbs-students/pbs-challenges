# PBS 150 StdIO

## Abstract

Modify the program from pbs-149-getopts to take one additional option:
-m <menufile.txt> or '-' for std in.

## Notes

-m <menufile.txt> already exists in my solution.
What is needed is to check for the '-' pseudo filename.
If present, do not read from the supplied file but use $(cat) as the stdin source.

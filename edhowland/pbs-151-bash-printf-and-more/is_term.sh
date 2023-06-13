#!/usr/bin/env bash
# is_term.sh: prints term if stdin is connected to terminal else pipe
if [ -t 0 ]
then
  echo input is from term > /dev/tty
  else
  echo input is from pipe > /dev/tty
fi
# checkstdout
if [ -t 1 ]
then
  echo output is to term > /dev/tty
else
  echo output is to pipe > /dev/tty
fi

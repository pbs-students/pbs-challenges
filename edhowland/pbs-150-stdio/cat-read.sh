#!/usr/bin/env bash
foo=$(cat -)
exec < /dev/stdin
read -p "what is bar" bar
echo foo is $foo
echo bar is $bar


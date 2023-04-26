#!/usr/bin/env bash
source load_menu.sh
load_menu $1
echo There are max_items "$max_items"
for l in "${menu[@]}"
do
  echo $l
done


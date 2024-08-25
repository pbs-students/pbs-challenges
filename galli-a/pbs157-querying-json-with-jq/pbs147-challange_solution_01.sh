#!/usr/bin/env bash

jq '.prizes[] |
    select(any(.laureates[]?; .firstname == "Andrea" and .surname == "Ghez")) |
    (.year, .category, (.laureates[]? | select(.firstname == "Andrea" and .surname == "Ghez") | .motivation))' \
    NobelPrizes.json
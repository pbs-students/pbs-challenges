#!/usr/bin/env bash

jq '.prizes[] |
	select(any(.laureates; length == 1)) |
	(.year, .category, (.laureates[0] | (.firstname, .surname, .motivation)))' \
	NobelPrizes.json
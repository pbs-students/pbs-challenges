#!/usr/bin/env bash

jq '.prizes[] |
	select(any(.laureates; length > 0)) |
	(.year, .category, (.laureates | length))' \
	NobelPrizes.json
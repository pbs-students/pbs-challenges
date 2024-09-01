#!/usr/bin/env bash

jq -r '[.prizes[] |
	select(any(.laureates[]?; length > 0)) |
	{
		year: .year | tonumber,
		prize: .category,
		numWinners: .laureates | length,
		winners: [.laureates[] | (["\(.firstname)", ("\(.surname // empty)")] | join(" "))]
	}] | @json' \
	NobelPrizes.json > NobelPrizeList.json
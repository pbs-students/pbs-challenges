#!/usr/bin/env bash

jq '.prizes[] |
    .laureates[]? |
    select(.motivation | test("\\bquantum")) |
    (.firstname, .surname, .motivation)' \
    NobelPrizes.json

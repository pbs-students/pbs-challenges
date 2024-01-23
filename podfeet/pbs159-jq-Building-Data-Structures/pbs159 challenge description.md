# An Optional Challenge

Using the Nobel Prizes data set as the input, build a simpler data structure to represent just the most important information.

The output data structure should be an array of dictionaries, one for each prize that was actually awarded, indexed by the following fields:

| Field        | Type             | Description                            |
| ------------ | ---------------- | -------------------------------------- |
| `year`       | Number           | The year the prize was awarded.        |
| `prize`      | String           | The category the prize was awarded in. |
| `numWinners` | Number           | The number of winners.                 |
| `winners`    | Array of Strings | The names of all the winners.          |

Years where there were no prizes awarded should be skipped.

As an example, when pretty printed, the entry for the 1907 peace prize should look like this:

```json
{
  "year": 1907,
  "prize": "peace",
  "numWinners": 2,
  "winners": [
    "Ernesto Teodoro Moneta",
    "Louis Renault"
  ]
}
```

The final output should be in JSON format (all on one line not pretty printed) and should be sent to a file named `NobelPrizeList.json`.

### A Warning and a Tip

The prizes awarded to organisations rather than specific people are likely to trigger a subtle bug in your output — a trailing space at the end of the name due to the fact that the dictionaries representing laureates that are organisations rather than people have no surnames.

To get full credit you should remove this trailing space using the same technique used to remove the leading and trailing quotation marks in one of the examples in this instalment.

A good test for your logic is the 1904 peace prize, the dictionary for which should look like:

```json
{
  "year": 1904,
  "prize": "peace",
  "numWinners": 1,
  "winners": [
    "Institute of International Law"
  ]
}
```

**Purely for bonus credit**, you can avoid the need to trim the space from the end of organisational winners by ensuring it never gets added. One way to achieve this is to combine the following jq functions and operators:

1. The alternate operator (`//`)
2. The `empty` function — we've not seen it yet, but it takes no arguments and returns absolute nothingness
3. The `join` function

Note that `["Bob", "Dylan"] | join(" ")` results in `"Bob Dylan"`, but `["Bob"] | join(" ")` results in just `"Bob"`.
#!/bin/bash

# Take values from the last (data) line only
# today_temp is token 4 (e.g., 22(25)) → keep only leading number
today_temp=$(tail -1 rx_poc.log | cut -d " " -f4 | sed -E 's/^(-?[0-9]+).*/\1/')

# yesterday_fc is token 6 (e.g., 23(25)) → keep only leading number
yesterday_fc=$(tail -1 rx_poc.log | cut -d " " -f6 | sed -E 's/^(-?[0-9]+).*/\1/')

accuracy=$((yesterday_fc - today_temp))
echo "accuracy is $accuracy"

if [ -1 -le "$accuracy" ] && [ "$accuracy" -le 1 ]; then
    accuracy_range=excellent
elif [ -2 -le "$accuracy" ] && [ "$accuracy" -le 2 ]; then
    accuracy_range=good
elif [ -3 -le "$accuracy" ] && [ "$accuracy" -le 3 ]; then
    accuracy_range=fair
else
    accuracy_range=poor
fi

echo "Forecast accuracy is $accuracy_range"

row=$(tail -1 rx_poc.log)
year=$(echo "$row" | cut -d " " -f1)
month=$(echo "$row" | cut -d " " -f2)
day=$(echo "$row" | cut -d " " -f3)

echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv

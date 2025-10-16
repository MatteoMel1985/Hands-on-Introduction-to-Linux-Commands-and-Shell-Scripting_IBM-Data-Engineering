#!/bin/bash

# Iterate over consecutive pairs of lines (previous day + current day)
total_lines=$(wc -l < rx_poc.log)
processed=0

# Start from line 2 so we always have a "previous" line
for i in $(seq 2 "$total_lines"); do
    # Previous day's raw line
    prev_line_raw=$(head -n $((i-1)) rx_poc.log | tail -1)
    # Current day's raw line
    curr_line_raw=$(head -n $i rx_poc.log | tail -1)

    # Collapse tabs/multiple spaces to a single space so field positions are predictable
    prev_line=$(echo "$prev_line_raw" | tr -s '[:space:]' ' ')
    curr_line=$(echo "$curr_line_raw" | tr -s '[:space:]' ' ')

    # Skip non-data lines (e.g., header). Data lines must start with a 4-digit year.
    echo "$prev_line" | grep -qE '^[[:space:]]*[0-9]{4}\b' || continue
    echo "$curr_line" | grep -qE '^[[:space:]]*[0-9]{4}\b' || continue

    # Take values and keep only the leading number (handles 22(25), 18, -3(1), etc.)
    # TODAY's observed temp from CURRENT line: field 4
    today_temp=$(echo "$curr_line" | cut -d " " -f4 | sed -E 's/^(-?[0-9]+).*/\1/')
    # YESTERDAY's forecast temp from PREVIOUS line: field 6
    yesterday_fc=$(echo "$prev_line" | cut -d " " -f6 | sed -E 's/^(-?[0-9]+).*/\1/')

    # If parsing failed for any reason, skip this pair safely
    [ -n "$today_temp" ] && [ -n "$yesterday_fc" ] || continue

    # Compute accuracy and classify
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

    # Use the CURRENT line's date for the report row (fields 1–3)
    year=$(echo "$curr_line" | cut -d " " -f1)
    month=$(echo "$curr_line" | cut -d " " -f2)
    day=$(echo "$curr_line" | cut -d " " -f3)

    # Append to historical TSV (tab-delimited)
    echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv

    processed=$((processed+1))
done

# Friendly note if nothing was processed
if [ "$processed" -eq 0 ]; then
    echo "No day-pairs processed. Need at least 2 data rows (excluding header) in rx_poc.log."
fi

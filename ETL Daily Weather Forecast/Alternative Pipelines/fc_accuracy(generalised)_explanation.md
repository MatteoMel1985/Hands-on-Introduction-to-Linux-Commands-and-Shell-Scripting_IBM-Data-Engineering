# ***Introduction***

[fc_accuracy(generalised).sh](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/fc_accuracy(generalised).sh) is the evolution [fc_accuracy(single_day).sh](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/fc_accuracy(single_day).sh); indeed, its same code structure was implemented to calculate the accuracy of all the predictions reported in the file [rx_poc.log](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/rx_poc.log).  
Since, in the version uploaded in this repository, `rx_poc.log` only has one line, the code suggested by the courser won't work; therefore, I had to adjust it and implement an error handling section.  
Following are the section entered to extend the originaly body of `fc_accuracy` to all days.  

# ***Scope: Multi-day script iterates across all consecutive pairs***

```bash
# Iterate over consecutive pairs of lines (previous day + current day)
total_lines=$(wc -l < rx_poc.log)
processed=0

# Start from line 2 so we always have a "previous" line
for i in $(seq 2 "$total_lines"); do
```

* `total_lines=$(wc -l < rx_poc.log)` counts lines.
    * `wc -l`: `wc` stands for "word count", whereas `-l` refers to "lines". The function of the bash combination `wc -l` is to count the line of `rx_poc.log`.
    * `< rx_poc.log` redirects file to `wc` (no echo).
    * `total_lines` stores the number of lines in the file `rx_poc.log`.
    * `processed=0` acts as a counter, starting at zero, that tracks how many data pairs were successfully analyzed inside the loop.
* `for i in $(seq 2 "$total_lines")` do loops `i` from 2 to the last line number.
    * Starting at `2`, ensures each iteration has a previous (i-1) and current (i) line.
* This generalizes the logic to all adjacent line pairs: `(1,2), (2,3), …`.

# ***Multi-day: head/tail to pick exact lines per iteration***  

While in the previous version we had `row=$(tail -1 rx_poc.log)`, that only read the last line; however, since now we are comparing multiple lines, we implemented this section as follows.  

```bash
prev_line_raw=$(head -n $((i-1)) rx_poc.log | tail -1)
curr_line_raw=$(head -n $i rx_poc.log | tail -1)
```

* `head -n $((i-1))` prints the first (i-1) lines; `tail -1` picks the last of those (the *(i-1)th* line).
* `head -n $i | tail -1` picks the ith line.
* These two lines form the (yesterday, today) pair.

Why this matters: you explicitly requested “Use `head` and `tail` to extract consecutive pairs of lines on each iteration.”  

# ***Whitespace normalization (new in multi-day)***  

```bash
prev_line=$(echo "$prev_line_raw" | tr -s '[:space:]' ' ')
curr_line=$(echo "$curr_line_raw" | tr -s '[:space:]' ' ')
```

* `tr -s '[:space:]' ' '` collapses any mix of tabs/spaces into single spaces.
* This makes field positions stable for `cut -d " " -fN` even when the log has `\t`, multiple spaces, or symbols like `°`.

The single-day version didn’t need this when the last line was well-behaved, while the multi-day version must handle every line consistently.  

***Defensive header/data checks (new in multi-day)***  

```bash
echo "$prev_line" | grep -qE '^[[:space:]]*[0-9]{4}\b' || continue
echo "$curr_line" | grep -qE '^[[:space:]]*[0-9]{4}\b' || continue
```

* `grep -qE` performs a silent extended-regex match.
    * `grep` stands for "Global Regular Expression Print" and is the main utility used to search for lines matching a pattern.
    * `-q`, or "Quiet or Silent", is the crucial flag. It suppresses all normal output. grep will not print any lines to the standard output, even if it finds a match.
    * `-E`, or "Extended Regex" treats the pattern as an Extended Regular Expression (ERE). EREs allow for more powerful and readable patterns using special characters like `+`, `?`, etc.
* Regex: `^[[:space:]]*[0-9]{4}\b`
    * `^` start of line
    * `[[:space:]]*` optional leading whitespace
    * `[0-9]{4}` exactly four digits (a year)
    * `\b` word boundary (ensures it’s a standalone year, not “20250”)
* `|| continue` if the line doesn’t look like data (for example, such as the header “year”), skip this iteration safely.

# ***Defensive header/data checks (new in multi-day)***  

```bash
today_temp=$(echo "$curr_line" | cut -d " " -f4 | sed -E 's/^(-?[0-9]+).*/\1/')
yesterday_fc=$(echo "$prev_line" | cut -d " " -f6 | sed -E 's/^(-?[0-9]+).*/\1/')
```

* `today_temp` is the current day’s observed temperature (field 4).  
* `yesterday_fc` is the previous day’s forecast temperature (field 6).  
* This is the key semantic generalization: we’re comparing yesterday’s forecast with today’s observation across all days, not just on the last record.

The parsing details remained unchanged in this snippet.  

# ***Parsing guards (new in multi-day)***  

```bash
[ -n "$today_temp" ] && [ -n "$yesterday_fc" ] || continue
```

* `[ -n VAR ]` true if the string is non-empty.
* If either value is empty (malformed line), `|| continue` skips the pair rather than crashing arithmetic.

The single-day version of the code assumed that the last line is parsable.  
The **accuracy computation** and **classification logic** remained identical in both codes.  

# ***Date extraction row source***  

```bash
year=$(echo "$curr_line" | cut -d " " -f1)
month=$(echo "$curr_line" | cut -d " " -f2)
day=$(echo "$curr_line" | cut -d " " -f3)
```

* The date used for the report row is always the today/current day of the pair.
* This makes each output row reflect the day whose observation you used.

Also the **Appending to the historical report** remained identical.  

```bash
processed=$((processed+1))
```
 * Counts how many pairs were successfully processed.

```bash
if [ "$processed" -eq 0 ]; then
    echo "No day-pairs processed. Need at least 2 data rows (excluding header) in rx_poc.log."
fi
```

* And a friendly message at the end

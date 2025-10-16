# ***Preliminary Requirements***

1. `fc_accuracy(single_day)` reads the tail of this specific [rx_poc.log](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/rx_poc.log) file, which was previously created and filled by launching the script [rx_poc.sh](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/rx_poc.sh) (see [Code Explanation.md](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/Code%20Explanation.md_)).

| year | month | day | obs_temp | fc_temp |
| ---- | ----- | --- | -------- | ------- |
| 2025 | 10 | 08 | 22(25) °C | 23(25) ° C |

2. The tab-delimited file named `historical_fc_accuracy.tsv` must be created by running the following command in the terminal:

```bash
echo -e "year\tmonth\tday\tobs_temp\tfc_temp\taccuracy\taccuracy_range" > historical_fc_accuracy.tsv
```

3. The script `fc_accuracy.sh` must also be created by launching the following string from the terminal:

```bash
touch fc_accuracy.sh
```

4. The script should be made executable by running

```bash
chmod u+x fc_accuracy.sh
```

# ***`fc_accuracy(single_day).sh`: a script to Report Historical Forecasting Accuracy***  

## ***1. Script Declaration***  

```bash
#!/bin/bash
```

This shebang line tells the system to run the script using the Bash shell.  

* `#!` (Shebang) is a special "magic number" recognised by the operating system. When the OS encounters these two characters at the beginning of an executable file, it interprets the rest of the line as the path to the interpreter that should be used to execute the file.
* `/bin/bash` is the absolute path to the Bash interpreter executable. It tells the operating system to use the Bash shell to interpret and run the commands within the script.

In essence, `#!/bin/bash` means: "Execute this script using the Bash interpreter located at `/bin/bash`."  

## ***2. Extract Today’s Observed Temperature***  

It is worth noting that our `rx_poc.log` file, run on October 8th 2025, shows the values `22(25) °C` in the `tobs_temp` column and `23(25) ° C` in `tfc_temp`, therefore, the strings previously suggested in the course to calculate the yesterday's and today's temperature (specifically `yesterday_fc=$(tail -2 rx_poc.log | head -1 | cut -d " " -f5)` and `today_temp=$(tail -1 rx_poc.log | cut -d " " -f4)`) will threw an error. To avoid them, I have modified the code as follows.  

```bas
today_temp=$(tail -1 rx_poc.log | cut -d " " -f4 | sed -E 's/^(-?[0-9]+).*/\1/')
```

* `$( ... )` is a command substitution. It captures the command’s standard output (stdout) and assigns it to the variable `today_temp`.
* `tail -1 rx_poc.log` emits only the last line of the file. The most recent observation/forecast is indeed on the last line.
* `cut -d " " -f4` extracts the 4th field from that last line.
    * `-d " "` sets the field delimiter character for `cut`. It uses a single space character as the separator.
    * `-f` selects which fields to output, therefore,
    * `-f4` selects only the 4th field.
 
The log file input is comprised of 8 fields.

```bash
  1:2025  2:10  3:08  4:22(25)  5:°C  6:23(25)  7:°  8:C
````

Therefore, `-f4` will yield  

```bash
22(25)
```

* `sed -E 's/^(-?[0-9]+).*/\1/'` cleans the 4th field so that only the leading integer remains.
    * `sed` is a stream editor that reads input line(s) and applies editing commands. For each line, it applies the script and prints the transformed line (unless `-n` is used).
    * `-E` is an ERE (Extended Regular Expression. With it, we can write `(...)`, `+`, `?` without backslashes.  
    
* `s/^(-?[0-9]+).*/\1/` is a substitution based on the form `s/<regex>/<replacement>/`.
    * `^` is an anchor at the start of the string. It ensures we only match if the very first characters are a number (possibly negative).
    * `( … )` is the capturing group 1. Everything matched inside becomes `\1` in the replacement.
    * `-?` introduces the optional minus sign. It matches either a single - or nothing. (Example matches: `-12`, `7`, `0`).
    * `[0-9]+` ensures we have an integer of at least one digit.
    * `.*` Refers to any characters (including none), to the end of the line. It “soaks up” everything after the leading integer: e.g., `(25)`, `°C`, etc.
 
Putting it together, the regex only matches if the string starts with an optional minus + digits. Examples:  

* `"22(25)"` match: group 1 = `22`, `.*` = `(25)`
* `"-3°C"` match: group 1 = `-3`, `.*` = `°C`
* `"abc"` no match (doesn’t start with a number), so no substitution occurs.

Replacement part: `\1`  

* It replaces the entire matched text with the content of capture group 1 (the leading integer). Examples:
    * `"22(25)"` = `"22"`
    * `"-3°C"` = `"-3"`
    * `"abc"` = unchanged (because no match, so no substitution)
 
## ***3. Extract Yesterday’s Forecast Temperature***  

```bash
yesterday_fc=$(tail -1 rx_poc.log | cut -d " " -f6 | sed -E 's/^(-?[0-9]+).*/\1/')
```

* Same logic as above, but for the 6th field, which represents the forecast temperature.

## ***4. Compute Forecast Accuracy***  

```bash
accuracy=$((yesterday_fc - today_temp))
echo "accuracy is $accuracy"
```

* `$(( ... ))` performs integer arithmetic in Bash.
* The script calculates the difference between forecast and observed temperature.
* Then it prints the result, e.g., `accuracy is 1`.

## ***5. Classify the Forecast Accuracy Range***  

```bash
if [ -1 -le "$accuracy" ] && [ "$accuracy" -le 1 ]; then
    accuracy_range=excellent
elif [ -2 -le "$accuracy" ] && [ "$accuracy" -le 2 ]; then
    accuracy_range=good
elif [ -3 -le "$accuracy" ] && [ "$accuracy" -le 3 ]; then
    accuracy_range=fair
else
    accuracy_range=poor
fi
```

The first line `if [ -1 -le "$accuracy" ] && [ "$accuracy" -le 1 ]; then` checks whether the numeric value stored in the variable `$accuracy` lies between –1 and +1 (inclusive). If true, the code inside this `if` branch will run.  

* `[ ... ]` are Bash test brackets, equivalent to the test command. The expression inside them evaluates a condition (like numeric comparison or string match).
* `-1 -le "$accuracy"`
    * `-le` means less than or equal to.
    * The left operand (`-1`) and right operand (`"$accuracy"`) are treated as integers. This part checks: “Is –1 ≤ accuracy ?”. If `$accuracy` were `0`, this would be true.
* `&&` is the logical AND operator in Bash.
* `[ "$accuracy" -le 1 ]` same form as before, but now it checks whether `accuracy ≤ 1`. Together, the two tests read as: `-1 ≤ accuracy ≤ 1`.
* `then`: when the condition is true, Bash executes the commands up to the next `elif`, `else`, or `fi`.
* `accuracy_range=excellent` is how the value is classified if it is comprised between `-1 ≤ accuracy ≤ 1`.

The other strings of the code, such as 

```bash
elif [ -2 -le "$accuracy" ] && [ "$accuracy" -le 2 ]; then
    accuracy_range=good
```

And 

```bash
elif [ -3 -le "$accuracy" ] && [ "$accuracy" -le 3 ]; then
    accuracy_range=fair
else
    accuracy_range=poor
```

Follows the same logic.  

* `fi` marks the end of the `if` statement block.  

## ***6. Display the Forecast Classification***  

```bash
echo "Forecast accuracy is $accuracy_range"
```

* Prints the qualitative result for the user (for exmample, if `$accuracy` is between `-1` and `1`, will print “Forecast accuracy is excellent”).

## ***7. Extract Date Components***  

```
row=$(tail -1 rx_poc.log)
year=$(echo "$row" | cut -d " " -f1)
month=$(echo "$row" | cut -d " " -f2)
day=$(echo "$row" | cut -d " " -f3)
```

* `row=$(tail -1 rx_poc.log)` stores the entire last line in a variable.
* Each `cut -d " " -fN` extracts the 1st, 2nd, and 3rd space-separated fields  (`year`, `month`, and `day`).

## ***8. Append Results to Historical File***  

```bash
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv
```

* `echo -e` enables interpretation of escape characters like `\t` (tab).
* The line prints the results as a tab-separated row containing `year`,  `month`,  `day`,  `obs_temp`,  `fc_temp`,  `accuracy`,  and `accuracy_range`.
* `>>` appends this new row to the end of the file `historical_fc_accuracy.tsv`.



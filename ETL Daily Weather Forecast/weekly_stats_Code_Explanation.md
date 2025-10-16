# Introduction

[weekly_stats.sh](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/weekly_stats.sh) is a script that reports weekly statistics of historical forecasting accuracy.  
The syntethic historical forecasting accuracy is stored in the file [synthetic_historical_fc_accuracy.tsv](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/synthetic_historical_fc_accuracy.tsv), which can be downloaded by launching the following command on the terminal.  

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-LX0117EN-Coursera/labs/synthetic_historical_fc_accuracy.tsv
```

Following is the explanation of `weekly_stats.sh`.  

# ***1. Shebang***  

```bash
#!/bin/bash
```  

* `#!` is the shebang marker telling the OS which program should run this file.
* `/bin/bash` is the absolute path to the Bash interpreter. It ensures your script runs with Bash.

# ***2. Build the Scratch File***  

```bash
echo $(tail -7 synthetic_historical_fc_accuracy.tsv | cut -f6) > scratch.txt
```

* `echo …` prints its arguments to standard output.
* `$( … )` is a command substitution: it runs the inner command and replace the whole `$( … )` with its output.
* `tail -7 synthetic_historical_fc_accuracy.tsv`:
    * `tail` prints the end of a file.
    * `-7 `refers to its last 7 lines (same as `-n 7`).
    * `synthetic_historical_fc_accuracy.tsv` is the file from which `tail -7` will be extracted.
* `|` is a pipe: it sends the output from the command on the left into the command on the right as input.
* `cut -f6`
    * `cut` extracts columns/fields.
    * `-f6` takes the 6th tab-separated field (the one under the `accuracy` attribute).
* `> scratch.txt` is a redirection: it writes the final echo output to (overwriting) the file `scratch.txt`. Note that `echo $(…)` will flatten all 7 lines into one space-separated line (newlines become spaces).

# ***3. Create an Array From the Scratch File***  

```bash
week_fc=($(echo $(cat scratch.txt)))
```

* `week_fc=( … )` is an array assignment; words inside become elements, split on IFS (defaults include spaces/newlines/tabs).
* `$(cat scratch.txt)` reads the file and substitutes its contents.


# ***4. Validate contents (first pass)***  

```bash
# validate result:
for i in {0..6}; do
    echo ${week_fc[$i]}
done
```

* `for i in {0..6}; do … done`: the loop is based on the following formula:

```bash
for variable in list; do
    commands
done
```

* `for` introduces a loop in Bash
* `variable`: name of the loop variable (in our case is `i`).
* `list` is a series of space-separated values to iterate over.
* `do` marks the start of the loop body.
* `done` marks the end of the loop body.

So, for every value in the list, Bash assigns that value to the loop variable (i), executes the commands inside, and repeats until the list is exhausted.  
In our case, we have:  

* `{0..6}` is a brace expansion expression, a Bash feature that expands into a sequence of numbers or letters (`i=0, i=1, i=2, i=3, i=4, i=5, i=6`). Each iteration, the code inside the loop will run once for each of those values (a total of 7 times).
* `echo ${week_fc[$i]}` is the loop body.
    * `echo` is a built-in Bash command that prints its arguments to standard output (usually your terminal).
    * `${ … }` are braces used to delimit a variable expansion clearly (so the shell knows exactly where the variable name ends).
    * `week_fc` is the array name.
    * `[ ]` is an array indexing syntax.
    * `$i` is the index variable.
* `done` marks the end of the for loop’s body.

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


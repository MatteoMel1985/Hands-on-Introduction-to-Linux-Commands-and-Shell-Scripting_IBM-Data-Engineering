# Preliminary requirements  

Before compiling `rx_poc.sh`, it is necessary to set up the environment.  

# *Create an Empty Log File* 

```bash
touch rx_poc.log
```

* `touch` is a standard Unix command used to create empty files or update file timestamps.
* `rx_poc.log` is the name of the file to create.

If the file does not exist, `touch` creates an empty file named `rx_poc.log`, if the file already exists, it simply update its modification timestamp (to mark it as “recently changed”). It doesn’t delete or overwrite its content.  

# *Write the Log File Header*  

```bash
echo -e "year\tmonth\tday\tobs_temp\tfc_temp">rx_poc.log
```

This command initialises the log file with column headers, like a CSV or table title row, using `echo`.  

* `echo` is a built-in command that prints text or variables to the terminal.
* `-e` enables interpretation of escape sequences (special backslash codes). Without `-e`, characters like `\t` or `\n` would appear literally, whereas with `-e`, they are translated (e.g., `\t` → tab, `\n` → newline).
* `"year\tmonth\tday\tobs_temp\tfc_temp"` is the quoted string is the text to print.
    * `year`, `month`, `day`, `obs_temp`, and `fc_temp` are column names.


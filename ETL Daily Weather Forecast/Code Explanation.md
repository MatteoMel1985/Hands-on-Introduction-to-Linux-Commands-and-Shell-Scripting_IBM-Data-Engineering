# **Preliminary requirements**  

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
    * `\t` is the tab character: it creates tab-separated fields (for clean alignment in logs or when opening the file in Excel).
* `>` is a redirection operator. It takes the output of the command on the left (`echo ...`) and writes it to the file on the right (`rx_poc.log`).

# *Create the Bash Script File*  

```bash
touch rx_poc.sh
```

Just like the first touch command, this creates a new empty file named `rx_poc.sh`  
Once the string is run, we will be able to see `rx_poc.sh` appearing in the explorer pane on the upper-left side of the EDI.  

# *Make the Script Executable*  

```bash
chmod u+x rx_poc.sh
```  

This is a crucial step that gives execution permission to the user for your script file.  

* `chmod` is short for “change mode”, and it is used to modify file permissions (read, write, execute) in Unix/Linux.
* `u+x` is the permission modification instruction.
    * `u` = user (the owner of the file).
    * `+x` = add execute permission.
So `u+x means` *“Give the user (file owner) permission to execute this file as a program.”*
* `rx_poc.sh` is the target file whose permissions you’re changing.

At this point in the work, we should be able to visualise the `rx_poc.sh` file appearing in the Explorer pane on the upper-left side of our EDI screen. Thus, we can double-click it and begin the scripting. 

![Screenshot 11](https://github.com/MatteoMel1985/Relational-Dataset-Images/blob/main/Linux%20Images/Screenshot%2011.JPG?raw=true)  

# **`rx_poc.sh`**  

# *Section 1: Shebang — Script Interpreter*  

```bash
#! /bin/bash
```

* `#!` (pronounced “shebang”), tells the system which interpreter to use to execute this file.
* `/bin/bash` is the path to the Bash shell binary, which interprets the commands in the script. This ensures the script runs in Bash, not another shell (like sh or zsh).

# *Section 2: Define the City Variable*   

```bash
#Assign city name as Casablanca
city=Casablanca
```

* `city=Casablanca` creates a variable named city and assigns it the string value "Casablanca" (no spaces are allowed around the `=` in Bash.).

# *Section 3: Download the Weather Report*  

```bash
#Obtain the weather report for Casablanca
curl -s wttr.in/$city?T --output weather_report
```

* `curl` is a command-line tool to transfer data from or to a server.
* `-s` stands for silent mode, implying no progress bar or error messages.
* `wttr.in/$city?T`:
    * Fetches weather for Casablanca (`$city` expands to `Casablanca`).
    * `?T` means “show in terminal-friendly format with Celsius temperature”.
* `--output weather_report` saves the fetched content into a file named weather_report (instead of printing it).

✅ After this command, a file named `weather_report` with Casablanca’s weather report will be issued.  

# *Section 4: Extract the Current Temperature*  

```bash
#To extract Current Temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current Temperature of $city: $obs_temp"
```

* `obs_temp=...` assigns the extracted value to variable `obs_temp`.
* `$( ... )` is a command substitution: it runs the command and stores its output in a variable.
* `curl -s wttr.in/$city?T` downloads the weather data again (in text form).
* `|` is a pipe: it sends the output of one command into the next.
* `grep -m 1 '°.'`
    * `grep` searches for a pattern.
    * `'°.'` finds the first line containing a degree symbol (°) followed by any character.
    * `-m 1` means stop after the first match (we only need one line).
    * `echo "The current Temperature of $city: $obs_temp"` prints the result to the terminal.  

# *Section 5: Extract Forecast Temperature for Tomorrow Noon*  

```bash
# To extract the forecast tempearature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"
```

* `fc_temp=...` assigns the extracted value to variable `fc_temp=...`.
* `$( ... )` is a command substitution: it runs the command and stores its output in a variable.
* `curl -s wttr.in/$city?T` fetches text weather data again.
* `head -23` takes the first 23 lines of the report.
* `tail -1` takes the last line of those 23.
* `grep '°.'` filters only lines containing a degree symbol (°).
* `cut -d 'C' -f2`
    * `cut` splits the line by the delimiter `'C'`.
    * `-f2` takes the second field, discarding everything before the first `'C'`.
 * `grep -Eo -e '-?[[:digit:]].*'`
    * `grep` searches for a pattern.
    * `-E` enables Extended Regular Expressions (ERE). Without `-E` we would need to type special characters like `\?`, `\+`, etc., wheareas with `-E`, we can just use `?`, `+`, `|` directly.
* `-o` prints only the matching part of each line, not the entire line.
* `-e` specifies the pattern (regular expression) that grep should search for.
* `'-?[[:digit:]].*'`
    * `' ... '` in Bash, single quotes `' '` prevent variable expansion and interpretation of special characters. Everything inside is taken literally, which is ideal for regex patterns.
    * `-?` matches either nothing (for positive temperatures) or a single minus sign, for negative ones (`-` matches a literal minus sign, for negative numbers, and `?` means “the previous element is optional”).
* `[[:digit:]]`is a POSIX character class, enclosed in `[ ... ]`. It matches any digit 0–9.
* `.*` is the combination of two regex metacharacters:
    * `.` matches any single character (except newline).
    * `*`means “zero or more repetitions” of the preceding item.
* `echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"` prints the result neatly. 

In short, the whole script means: “Using extended regex rules, search each input line and print only the part that starts with an optional minus sign followed by a digit, and continue to the end of the line.”  

# *Section 6: Set the Timezone Variable*  

```bash
#Assign Country and City to variable TZ
TZ='Morocco/Casablanca'
```

* `TZ` is the timezone variable, recognised by many Unix utilities like `date`.
* It sets the timezone to Morocco/Casablanca

# *Section 7: Extract Current Date Components*  



This sets the timezone to Morocco/Casablanca, ensuring all time/date outputs are correct for that location.

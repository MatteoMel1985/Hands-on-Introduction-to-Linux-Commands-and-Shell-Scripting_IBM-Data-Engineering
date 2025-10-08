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

# Getting Started  

# ***Task 0***  

1. Open a new terminal by clicking on the menu bar and selecting Terminal->New Terminal.
  
2. Download the template file `backup.sh` by running the command below in the terminal:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/pWN3kO2yWEuKMvYJdcLPQg/backup.sh
```
Once run, `backup.sh` should be visible in the Explorer pane on the upper-left side of the IDE (integrated development environment)  

![Screenshot 1](https://github.com/MatteoMel1985/Relational-Dataset-Images/blob/main/Linux%20Images/Screenshot%201.JPG?raw=true)  

3. Open the file in the IDE by clicking File->Open as seen below:

<img src="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/file-open.png" alt="Open" width="40%">

then click on the file, which should have been downloaded to the project directory:

<img src="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/prompt-open.png" alt="Open" width="30%">

Once `backup.sh` is open, the script below will be visualised in the text editor of the IDE.  

```bash
#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=
destinationDirectory=

# [TASK 2]
echo ""
echo ""

# [TASK 3]
currentTS=``

# [TASK 4]
backupFileName=""

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=``

# [TASK 6]
cd # <-
destDirAbsPath=``

# [TASK 7]
cd # <-
cd # <-

# [TASK 8]
yesterdayTS=

declare -a toBackup

for file in  # [TASK 9]
do
  # [TASK 10]
  if (())
  then
    # [TASK 11]
  fi
done

# [TASK 12]

# [TASK 13]

# Congratulations! You completed the final project for this course!
```

Our job is to fulfil all its 13 + 4 additional tasks.  

# ***Task 1***  

We are now requested to set two variables equal to the values of the first and second command line arguments; however, before accomplising this job, I believe it is key to explain all the code, line-by-line, until the `# [TASK 1]` section.  

## ***Shebang: Choosing the Shell***  

```bash
#!/bin/bash
```

* The very first line is the shebang. It tells the operating system which program should interpret the rest of the file when you execute it.
* `/bin/bash` is the absolute path to the Bash shell binary.  

### ***Note***  

* On many Linux systems, /bin/bash exists; on some systems (e.g., certain BSDs or niche distros), Bash may live elsewhere. A more portable pattern is:

```bash
#!/usr/bin/env bash
```

which asks the environment to locate `bash` on the user’s `PATH`.  

## ***Argument Count Validation***  

```bash
# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi
```

* Everything written in the same line after the symbol `# ...` relates exclusively to comments whose function is to describe the process. The machine won't process these lines.
* `if [[ $# != 2 ]]`  
    * `[[ ... ]]` is Bash’s advanced test construct (safer than `[ ... ]`), avoiding unwanted globbing/word-splitting.
    * `$#` expands to the number of positional arguments passed to the script.
    * `!=` here performs string inequality inside `[[ ... ]]`.
* `then` begins the “true” branch.
* `echo "backup.sh target_directory_name destination_directory_name"` prints a usage hint.
* `exit` exits the script, while
* `fi` indicates the end of an `if` statement.

## ***Directory Path Validation***  

```bash
# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi
```

* `if [[ ! -d $1 ]] || [[ ! -d $2 ]]`
    * `-d` tests whether the operand is an existing directory.
    * `!` negates the test.
    * `||` is logical OR: if either `$1` or `$2` is not a directory, the condition is true.
    * `$1` and `$2` are special parameters known as positional parameters in Shell scripting. They represent the command-line arguments passed to the script when it is executed. `$1` refers to the first argument provided in the code, whereas `$2` references the second.
    * `then` enters error branch.
    * `echo "Invalid directory path provided"` prints the error.
    * `exit`, again, exits with the last command’s status.
    * `fi` also, as seen before, indicates the end of an `if` statement.
 
## ***Task 1 - Assign Arguments to Named Variables***

Finally, we can proceed with the accomplishment of our first task. As we are requested to set two variables equal to the values of the first and second command line arguments, given that the previous `if` statements quote `if [[ ! -d $1 ]] || [[ ! -d $2 ]]`, we can simply equate variable 1 to `$1` and variable 2 to `$2` as follows:  

```bash
# [TASK 1]
targetDirectory=$1
destinationDirectory=$2
```

Following is the `01-Set_Variables.jpg` screenshot that was requested to be uploaded for the completion of Task 1. 

![01-Set_Variables.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/01-Set_Variables.jpg?raw=true)  

# ***Task 2***  

The resolution of this task is still quite simple, as we are requested to display the values of the two command line arguments in the terminal. Since the provided code structure quotes `echo ""`, which already tells us that the values inserted between `""` will be printed, we can simply instruct the machine to print the following:  

```bash
# [TASK 2]
echo "targetDirectory is $1"
echo "destinationDirectory is $2"
```

Following is the `02-Display_Values.jpg` screenshot that was requested to be uploaded for the completion of Task 2.  

![02-Display_Values.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/02-Display_Values.jpg?raw=true)  

# ***Task 3***

Task 3 requires us to define a variable called `currentTS` as the current timestamp, expressed in seconds. To do so, we can complete the skeletal code ` currentTS=`` ` by adding the following. 

```bash
# [TASK 3]
currentTS=$(date +%s)
```

* `$( ... )` is command substitution. It runs the command inside and replaces the whole `$(...)` with the command’s output.  
* `date`: This is the standard Unix command for displaying or setting the system date and time.
* `+%s`: This is a format specifier for the date command. The `%s` specifier tells date to output the number of seconds that have elapsed since the Unix Epoch (January 1, 1970, 00:00:00 UTC). This value is also known as a Unix timestamp or epoch time.

Below is the requested screenshot named `04-Set_Value.jpg`.  

![03-CurrentTS.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/03-CurrentTS.jpg?raw=true)  

# ***Task 4***  

Proceeding with our work, we must now define a variable called `backupFileName` to store the name of the archived and compressed backup file that the script will create. The task's request proceeds with the following suggestion:  

*The variable `backupFileName` should have the value `"backup-[$currentTS].tar.gz"`.*
  * *For example, if `currentTS` has the value `1634571345`, then `backupFileName` should have the value `backup-1634571345.tar.gz`*.

Following the instructions, we can devise this string: 

```bash
# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"
```

This way, the variable creates a string like the one requested in the task.  
Below is also the screenshot `04-Set_Value.jpg`.  

![04-Set_Value.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/04-Set_Value.jpg?raw=true)  

# ***Task 5***  

Before proceeding with the project's instructions, it is worth quoting the skeletal code documentation written after the symbol `#`, which provides further explanation of the function performed by its following section.  

```bash
# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...
```

Task 5 asks us to define a variable called `origAbsPath` with the absolute path of the current directory as the variable's value. The following string perfectly follows this instruction.  

```bash
# [TASK 5]
origAbsPath=$(pwd)
```

* `pwd` prints the current working directory; capturing it allows us to come back to it later.

As per praxis, the following is the `05-Define_Variable.jpg` screenshot.  

![05-Define_Variable.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/05-Define_Variable.jpg?raw=true)  

# ***Task 6***  

Now, we are requested to define a variable called `destAbsPath`, whose value equals the absolute path of the destination directory. To do so, I devised the following code.

```bash
# [TASK 6]
cd $destinationDirectory
destAbsPath=$(pwd)
```

* `cd $destinationDirectory` changes the directory to the destination. The command `cd`, in Bash script, stands for change directory.  
* `destAbsPath=$(pwd)` captures its absolute path, by a relative input like `../backups` to an absolute path after the `cd`. `pwd`, indeed, stands for "print working directory" in Bash script.

Here is the requested screenshot `06-Define_Variable.jpg`.  

![06-Define_Variable.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/06-Define_Variable.JPG?raw=true)  

# ***Task 7***  

Now, we must change directories from the current working directory to the target directory `targetDirectory`. The hint of the task already tells us how to write the code, as it recites *`cd` into the original directory `origAbsPath` and then `cd` into `targetDirectory`.*  
By simply following this indication, we can compose  

```bash
# [TASK 7]
cd $origAbsPath 
cd $targetDirectory
```

Following is the screenshot `07-Change_Directory.jpg`.  

![07-Change_Directory.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/07-Change_Directory.jpg?raw=true)  

# ***Task 8***  

Finally, this job requires us to perform some computation, as we are tasked with finding files that have been updated within the past 24 hours. More specifically, it wants us to see all files whose last-modified date was 24 hours ago or less. To make this easier, the prompt suggests we define a numerical variable called `yesterdayTS` as the timestamp (in seconds) 24 hours before the current timestamp, `currentTS`.  
Interestingly, in the hint section, the following sentence teaches us how to structure the code:  

*Thus, to get the timestamp in seconds of 24 hours in the future, you would use: `tomorrowTS=$(($currentTS + 24 * 60 * 60))`*  

By applying the instructions and tweaking them to calculate the variable `yesterdayTS`, we can write:  

```bash
# [TASK 8]
yesterdayTS=$(($currentTS - 24 * 60 * 60))
```  

* Bash arithmetic expansion with `$(( ... ))` computes an integer: in our case, `currentTS - 86400`.
* `currentTS`, as explained in Task 3, represents our current timestamp, expressed in seconds. These seconds are calculated since the Unix Epoch, which is January 1, 1970, 00:00:00 UTC.
* The expression `24 * 60 * 60` calculates the total number of seconds in a 24-hour period.
    * `24` represents the number of hours in a day.
    * `60`: represents the number of minutes in an hour.
    * `60`: represents the number of seconds in a minute.
* By multiplying these three numbers together (`24 * 60 * 60`), the script determines the total number of seconds in a single day, which is 86,400.

 Here is the `08-YesterdayTS.jpg` screenshot.  

![YesterdayTS](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/08-YesterdayTS.jpg?raw=true)  

# ***Note on Arrays***  

The script proceeds with the following line:  

```bash
declare -a toBackup
```

It declares a variable called `toBackup`, which is an array. They contain a list of values, and items can be appended to them by using the following syntax:  

```bash
myArray+=($myVariable)
```

The following example shows how to append items to an array, and how they appear in a single line separated by spaces once they are `echo`ed. 

```bash
$ declare -a myArray
$ myArray+=("Linux")
$ myArray+=("is")
$ myArray+=("cool!")
$ echo ${myArray[@]}
Linux is cool!
```

# ***Task 9***  

Task 9 recites as follows: **"In the for loop, use the wildcard to iterate over all files and directories in the current folder."** Thus, we can complete the skeletal code in this fashion:  

```bash
for file in $(ls) # [TASK 9]
do
```

* `for file in $(ls)` runs `ls` (short of "list"), which is a command used to list the contents of a directory. It captures the output, then splits it on whitespace to produce a list for the `for` loop.

In conclusion of the job, attached is the `09-List_AllFilesandDirectoriess.jpg` screenshot.  

![09-List_AllFilesandDirectoriess.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/09-List_AllFilesandDirectoriess.jpg?raw=true)  

# ***Task 10***  

Since they were not covered in the *Hands-on Introduction to Linux Commands and Shell Scripting* course, both Tasks 10 and 11 are already resolved in the instructions. The first among them quotes:  

**Inside the for loop, you want to check whether the $file was modified within the last 24 hours.**
   *To get the last-modified date of a file in seconds, use `date -r $file +%s` then compare the value to `yesterdayTS`.* 
   *if `[[ $file_last_modified_date -gt $yesterdayTS ]]` then the file was updated within the last 24 hours!*  
**Since much of this wasn't covered in the course, for this task you may copy the code below and paste it into the double square brackets `[[]]`:**  

```bash
`date -r $file +%s` -gt $yesterdayTS
```

Thus, the completed `# TASK 10` snippet would look as follows:  

```bash
  # [TASK 10]
  if ((`date -r $file +%s` > $yesterdayTS))
  then
```

* `if` … ; `then` … `fi` are standard Bash conditional. If the test/expression inside evaluates as non-zero (true) in an arithmetic context (or exit status 0 if using command tests), the then branch executes; otherwise it skips to after fi. Here, we’re using arithmetic evaluation with `(( … ))`.
* `(( … ))` are Bash arithmetic evaluation. Inside `(( … ))`, the content is parsed as a numeric expression. Comparison operators like `>` are numeric comparisons here, and not redirections.
* `date` is the system utility for printing/formatting dates.
* `-r $file` GNU coreutils `date`: `-r FILE` (or `--reference=FILE`) means *“use the modification time of FILE as the date/time to format,”* rather than *“now.”* So with GNU `date`, `date -r $file …` formats the file’s mtime.
* `$file` expands to the current loop item (a filename).
* `+%s` is a format string for date, meaning “print the time as epoch seconds” (seconds since 1970-01-01 00:00:00 UTC). Thus, `date -r "$file" +%s` yields an integer timestamp representing the file’s last modification time.
* `>` Inside `(( … ))`, `>` is the numeric greater-than operator.
* `$yesterdayTS` is a shell variable defined earlier as a timestamp for “24 hours ago” (or `currentTS - 86400`). Because we’re in an arithmetic context, `$yesterdayTS` is treated as a number and compared numerically.

### ***IN SHORT***  

``(( \date -r $file +%s` > $yesterdayTS ))`` evaluates to true if the file’s modification time (in epoch seconds) is **strictly greater than** the cutoff timestamp for “yesterday.” In other words: *“Was this file modified within the last 24 hours?”* If yes, enter the then branch.  

After this explanation, I proceed by attaching the `10-IF_Statement.jpg` screenshot.  

![10-IF_Statement.jpg](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/Tasks/10-IF_Statement.jpg?raw=true)  

# ***Task 11***  


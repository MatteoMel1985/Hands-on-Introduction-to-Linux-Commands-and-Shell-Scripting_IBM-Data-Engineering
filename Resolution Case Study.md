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


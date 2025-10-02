<div align="center">
  <h1>Final Project Overview</h1>
</div>


![Skills_Network](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-PY0221EN-Coursera/images/image.png)    

# Scenario  

Imagine that you are a lead Linux developer at the top-tech company ABC International Inc. ABC currently suffers from a huge bottleneck: each day, interns must painstakingly access encrypted password files on core servers and back up any files that were updated within the last 24 hours. This process introduces human error, lowers security, and takes an unreasonable amount of work.  

As one of ABC Inc.'s most trusted Linux developers, you have been tasked with creating a script called `backup.sh` which runs every day and automatically backs up any encrypted password files that have been updated in the past 24 hours.  

# Objective  

In this Final Project, we will be required to submit the following tasks.  

# Task 1

Set two variables equal to the values of the first and second command line arguments, as follows:  

1. Set `targetDirectory` to the first command line argument  
2. Set `destinationDirectory` to the second command line argument

This task is meant to help with code readability.  
Take a screenshot of the code above and save it as `01-Set_Variables.jpg` or `.png`.  

# Task 2  

1. Display the values of the two command line arguments in the terminal.
2. Take a screenshot of the code above and save it as `02-Display_Values.jpg` or `.png`.

# Task 3  

1. Define a variable called `currentTS` as the current timestamp, expressed in seconds.
2. Take a screenshot of the code above and save it as `03-CurrentTS.jpg` or `.png`.

# Task 4  

1. Define a variable called `backupFileName` to store the name of the archived and compressed backup file that the script will create.
    * *The variable `backupFileName` should have the value `"backup-[$currentTS].tar.gz"`*
    * For example, if `currentTS` has the value `1634571345`, then `backupFileName` should have the value `backup-1634571345.tar.gz`.  

2. Take a screenshot of the code above and save it as `04-Set_Value.jpg` or `.png`.

# Task 5  

1. Define a variable called `origAbsPath` with the absolute path of the current directory as the variable's value.
2. Take a screenshot of the code above and save it as `05-Define_Variable.jpg` or `.png`.

# Task 6  

1. Define a variable called `destAbsPath` whose value equals the absolute path of the destination directory.
2. Take a screenshot of the code above and save it as `06-Define_Variable.jpg` or `.png`.

# Task 7  

1. Change directories from the current working directory to the target directory `targetDirectory`.
2. Take a screenshot of the code above and save it as `07-Change_Directory.jpg` or `.png`.

# Task 8  

1. Define a numerical variable called `yesterdayTS` as the timestamp (in seconds) 24 hours prior to the current timestamp, `currentTS`.
2. Take a screenshot of the code above and save it as `08-YesterdayTS.jpg` or `.png`.

# Note on Arrays

In the script, you will notice the line:  

```bash
declare -a toBackup
```

This line declares a variable called `toBackup`, which is an array. An array contains a list of values, and you can append items to arrays using the following syntax:  

```bash
myArray+=($myVariable)
```

When you print or `echo` an array, you will see its string representation, which is simply all of its values separated by spaces:  

```bash
$ declare -a myArray
$ myArray+=("Linux")
$ myArray+=("is")
$ myArray+=("cool!")
$ echo ${myArray[@]}
Linux is cool!
```

This will be useful later in the script where you will pass the array `$toBackup`, consisting of the names of all files that need to be backed up, to the `tar` command. This will archive all files at once!

# Task 9  

1. In the for loop, use the wildcard to iterate over all files and directories in the current folder.
2. Take a screenshot of the code above and save it as `09-List_AllFilesandDirectoriess.jpg` or `.png`.

# Task 10  

1. Inside the `for` loop, you want to check whether the `$file` was modified within the last 24 hours.

   * To get the last-modified date of a file in seconds, use `date -r $file +%s` then compare the value to `yesterdayTS`.
   * if `[[ $file_last_modified_date -gt $yesterdayTS ]]` then the file was updated within the last 24 hours!

2. Since much of this wasn't covered in the course, for this task you may copy the code below and paste it into the double square brackets `[[]]`:

```bash
`date -r $file +%s` -gt $yesterdayTS
```
3. Take a screenshot of the code above and save it as `10-IF_Statement.jpg` or `.png`.

# Task 11  

1. In the `if-then` statement, add the `$file` that was updated in the past 24-hours to the `toBackup` array.
2. Since much of this wasn’t covered in the course, you may copy the code below and place after the `then` statement for this task:

```bash
toBackup+=($file)
```

3. Take a screenshot of the code above and save it as `11-Add_File.jpg` or `.png`.

# Task 12  

1. After the `for` loop, compress and archive the files, using the `$toBackup` array of filenames, to a file with the name `backupFileName`.
2. Take a screenshot of the code above and save it as `12-Create_Backup.jpg` or `.png`.

# Task 13  

1. Now the file `$backupFileName` is created in the current working directory.  

<details>
<summary>Hint</summary>

<br>

*Move the file `backupFileName` to the destination directory located at `destAbsPath`.*  
<br>
</details>  

2. Take a screenshot of the code above and save it as `13-Move_Backup.jpg` or `.png`.

# Task 14  

1. Save the current working file `backup.sh` with `CTRL` + `s` [Windows/Linux], `CMD` + `s` [MAC] or by navigating to File->Save as shown below:  

![image](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/file-save.png)  

2. Download the file to your local computer by navigating to File->Download as seen below:  

![image](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/file-download.png)  


# Task 15  

1. Open a new terminal by clicking on the menu bar and selecting Terminal->New Terminal, as in the image below:  

![image](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/new-terminal.png)  

This will open a new terminal at the bottom of the screen as seen below:  

![image](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/images/terminal_bottom_screen.png)  

2. Save the `backup.sh` file you're working on and make it executable.

3. Verify the file is executable using the `ls` command with the `-l` option:  

```bash
ls -l backup.sh
```

4. Take a screenshot of the output of the command above and save it as `15-executable.jpg` or `.png`.

# Task 16  

1. Download the following .zip file with the wget command:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/important-documents.zip
```

2. Unzip the archive file:

```bash
unzip -DDo important-documents.zip
```

*Note: `-DDo` overwrites without restoring original modified date.*

3. Update the file’s last-modified date to now:

```bash
touch important-documents/*
```

4. Test your script using the following command:

```bash
./backup.sh important-documents .
```

*This should have created a file called `backup-[CURRENT_TIMESTAMP].tar.gz` in your current directory.*  

5. Take a screenshot of the output of ls -l and save it as `16-backup-complete.jpg` or `.png`.

# Task 17  

1. Copy the `backup.sh` script into the `/usr/local/bin/` directory. (Do not use mv.)  

2. Test the cronjob to see if the backup script is getting triggered by scheduling it for every 1 minute.  

3. Please note that since the Theia Lab is a virtual environment, we need to explicitly start the cron service using the below command:  

```bash
sudo service cron start
```

4. Once the cron service is started, check in the directory `/home/project` to see if the `.tar` files are being created.

5. If they are, then stop the cron service using the below command, otherwise it will continue to create `.tar` files every minute:

```bash
sudo service cron stop
```

6. Using crontab, schedule your `/usr/local/bin/backup.sh` script to backup the `important-documents` folder every 24 hours to the directory `/home/project`.

7. Take a screenshot of the output of `crontab -l` and save as `17-crontab.jpg` or `.png`.

# Author: [Matteo Meloni](https://www.linkedin.com/in/matteo-meloni-40a357154/)

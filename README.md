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
2. ake a screenshot of the code above and save it as `02-Display_Values.jpg` or `.png`.

# Task 3  

1. Define a variable called `currentTS` as the current timestamp, expressed in seconds.
2. Take a screenshot of the code above and save it as `03-CurrentTS.jpg` or `.png`.

# Task 4  

1. Define a variable called `backupFileName` to store the name of the archived and compressed backup file that the script will create.
    * *The variable `backupFileName` should have the value `"backup-[$currentTS].tar.gz"`*
    * For example, if `currentTS` has the value `1634571345`, then `backupFileName` should have the value `backup-1634571345.tar.gz`.  

2. Take a screenshot of the code above and save it as `04-Set_Value.jpg` or `.png`.


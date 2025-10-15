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

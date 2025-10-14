# ***Preliminary Requirements***

1. `fc_accuracy(single_day)` reads the tail of this specific [rx_poc.log](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/rx_poc.log) file, which was previously created and filled by launching the script `rx_poc.sh` (see [Code Explanation.md](https://github.com/MatteoMel1985/Hands-on-Introduction-to-Linux-Commands-and-Shell-Scripting_IBM-Data-Engineering/blob/main/ETL%20Daily%20Weather%20Forecast/Code%20Explanation.md_)).

| year | month | day | obs_temp | fc_temp |
| ---- | ----- | --- | -------- | ------- |
| 2025 | 10 | 08 | 22(25) °C | 23(25) ° C |

2. The tab-delimited file named `historical_fc_accuracy.tsv` must be created by running the following command by the terminal:

```bash
echo -e "year\tmonth\tday\tobs_temp\tfc_temp\taccuracy\taccuracy_range" > historical_fc_accuracy.tsv
```

3. The script `fc_accuracy.sh` must also be created by launching the following string from the terminal:

```bash
touch fc_accuracy.sh
```

4. The script should be made executable by running

```bash
chmod u+x fc_accuracy.sh
```

# ***`fc_accuracy.sh`: a script to Report Historical Forecasting Accuracy***


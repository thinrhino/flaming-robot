# Getting and Cleaning Data  
## Course Project  

### Assumptions
1. You have installed the packages "plyr" and "reshape2"
2. Download & unzip data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. Rename the folder to "uci"
4. Make sure the folder "uci" and the run_analysis.R script are both in the current working directory.
 
### Running the script   
1. Use source("run_analysis.R") command in RStudio.
2. The script will output two files in the current working directory:
    1. tidy_data_1.txt (8.2 MB), it contains the data frame tidy.data.1 (of dimension 10299x68). This file contains the first requirement of the assignment.
    2. tidy_data_1.txt (1.9 MB): it contains the data frame tidy.data.1 (of dimension 180x563). This file contains the second requirement of the assignment.
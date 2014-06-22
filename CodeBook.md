# Getting and Cleaning Data  
## Course Project  - Codebook

### Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Raw Data

| variable name | file name |
|-------------|---------|
|```features```|```uci/features.txt```|
|```raw.test.data``` | ```uci/test/X_test.txt```|
|```raw.test.activity``` | ```uci/test/y_test.txt```|
|```raw.test.subject``` | ```uci/test/subject_test.txt```|
|```raw.train.data``` | ```uci/train/X_train.txt```|
|```raw.train.activity``` | ```uci/train/y_train.txt```|
|```raw.train.subject``` | ```uci/train/subject_train.txt```|

All this data is merged into a single data frame as ```raw.data```

## Tidy Data 1
We are expected to extract the measurements on the mean and standard deviation for each measurement. Using ```grep``` for ```std()``` & ```mean()``` we extract the required column numbers and subset ```raw.data``` as ```tidy.data.1```.  

It is also required that ```tidy.data.1``` have descriptive feature names, we use ```make.names()``` to convert the ```features``` into syntactically valid names & rename the columns of ```tidy.data.1```.

The DataFrame ```tidy.data.1``` has 68 variables and 10299 observations.

This DataFrame is saved into a file ```tidy_data_1.txt```

## Tidy Data 2
We are expected to group the entire ```raw.data``` by ```subject.id``` & ```activity``` and calculate ```mean()``` of all the features.  

Using the package ```reshape2``` we ```melt()``` and then ```dcast``` ```raw.data```, based on ```activity``` & ```subject.id```

    md <- melt(raw.data, id = c("activity", "subject.id"))
    tidy.data.2 <- dcast(md, activity+subject.id~variable, mean)
  
The DataFrame ```tidy.data.2``` has 180 variables and 563 observations.

The DataFrame ```tidy.data.2``` is saved into a file ```tidy_data_2.txt```
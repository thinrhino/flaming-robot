library(plyr)

# Read features.txt
features <- read.table('features.txt', col.names = c('SrNo', 'feature'))

# Read test data
raw.test.data <- read.table('uci/test/X_test.txt',
                            header = FALSE,
                            col.name = c(1:561),
                            check.names = FALSE
                            )

raw.test.activity <- read.table('uci/test/y_test.txt',
                                header = FALSE,
                                col.name = c('activity')
                                )

raw.test.subject <- read.table('uci/test/subject_test.txt',
                               header = FALSE,
                               col.name = c('subject.id')
                               )
raw.test <- cbind(raw.test.subject, raw.test.activity, raw.test.data)

# Read train data

raw.train.data <- read.table('uci/train/X_train.txt',
                            header = FALSE,
                            col.name = c(1:561),
                            check.names = FALSE
)

raw.train.activity <- read.table('uci/train/y_train.txt',
                                header = FALSE,
                                col.name = c('activity')
)

raw.train.subject <- read.table('uci/train/subject_train.txt',
                               header = FALSE,
                               col.name = c('subject.id'),
                               colClasses = 'numeric'
)
raw.train <- cbind(raw.train.subject, raw.train.activity, raw.train.data)

# Merge Test & Train data
raw.data <- rbind(raw.test, raw.train)

# Rename activity values to descriptive activity values
raw.data$activity = mapvalues(raw.data$activity,
                              from = c(1, 2, 3, 4, 5, 6),
                              to = c('WALKING', 'WALKING_UPSTAIRS', 
                                     'WALKING_DOWNSTAIRS', 'SITTING',
                                     'STANDING', 'LAYING')
                              )

# Extract required columns from merged data
cols.mean <- grep("mean", features$feature)
cols.std <- grep("std", features$feature)
cols.req <- c(cols.mean, cols.std)
cols.req <- sort(cols.req)

# Subset raw.data for the required columns
tidy.data.1 <- raw.data[, cols.req]

# Write tidy data 1
write.table(tidy.data.1, file="tidy_data.txt", col.names = FALSE, row.names = FALSE)


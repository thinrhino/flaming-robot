library(plyr)
library(reshape)

# Read features.txt
features <- read.table('uci/features.txt', col.names = c('SrNo', 'feature'))

# Read test data
raw.test.data <- read.table('uci/test/X_test.txt',
                            header = FALSE,
                            col.name = c(1:561),
                            check.names = FALSE,
                            colClasses = "numeric"
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
                            check.names = FALSE,
                            colClasses = "numeric"
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
cols.mean <- grep("mean\\(\\)", features$feature, ignore.case = TRUE)
cols.std <- grep("std\\(\\)", features$feature, ignore.case = TRUE)
cols.req <- c(cols.mean, cols.std)
cols.req <- sort(cols.req)

# Subset raw.data for the required columns
req.cols <- c("subject.id", "activity", as.character(cols.req))
tidy.data.1 <- raw.data[, req.cols]
tidy.col.names <- make.names(gsub("\\(\\)", "", features$feature[cols.req]))

colnames(tidy.data.1) <- c("subject.id", "activity", tidy.col.names)

# Write tidy data 1
write.table(tidy.data.1,
            file="tidy_data.txt",
            quote = FALSE,
            col.names = TRUE,
            row.names = FALSE)

req.features <- features[cols.req,]
write.table(req.features$feature,
            file='features.tidy_data.txt',
            quote = FALSE,
            col.names = FALSE,
            row.names = TRUE)

# Create second tidy dataset
# Melting the raw.data
md <- melt(raw.data, id = c("activity", "subject.id"))

# Cast the melted data
tidy.data.2 <- cast(md, activity+subject.id~variable, mean)

# Naming the columns appropriately
full.col.names <- make.names(gsub("\\(\\)", "", features$feature))
colnames(tidy.data.2) <- c("subject.id", "activity", full.col.names)

write.table(tidy.data.2,
            file="tidy_data_2.txt",
            quote = FALSE,
            col.names = TRUE,
            row.names = FALSE)
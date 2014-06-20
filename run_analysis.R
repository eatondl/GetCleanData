## Load libraries
library(sqldf)
library(plyr)

## Set working directory
setwd("C:\\UCI HAR Dataset\\")

## Create Train file
## Read features file and assign column names
features <- read.table(file="features.txt")
feature_names <- features[,2]

## Read activity master file and assign column names
activity_labels <- read.table(file="activity_labels.txt")
names(activity_labels) <- c("Activity_Code", "Activity")

## Read subjects in training group file and assign column names
train <- read.table(file="train\\x_train.txt")
names(train) <- feature_names

## Assign record numbers to identifer so the correct subject and activity can be assigned
train_recnum <- rownames(train)
train <- cbind(train_recnum=train_recnum, train)

## Read training activity file and assign column names
train_labels <- read.table(file="train\\y_train.txt")
names(train_labels) <- c("Activity_Code")

## Read subject file and assign column names
subject_train <- read.table(file="train\\subject_train.txt")
names(subject_train) <- c("Subject_ID")

## Assign record numbers to identifer so the correct subject can be assigned
subject_recnum <- rownames(subject_train)
subject_train <- cbind(subject_recnum=subject_recnum, subject_train)

## Assign record numbers to identifer so the correct train activity can be assigned
activity_recnum <- rownames(train_labels)
train_labels <- cbind(activity_recnum=activity_recnum, train_labels)

##
train_activity_desc <-sqldf("SELECT train_labels.activity_recnum, train_labels.Activity_Code, activity_labels.Activity from activity_labels inner join train_labels on activity_labels.Activity_Code = train_labels.Activity_Code")

train_activity_c <- merge(x=train_activity_desc, y=train, by.x="activity_recnum", by.y="train_recnum")

train_subject_activity <- merge(x=subject_train, y=train_activity_c, by.x="subject_recnum", by.y="activity_recnum")


## Create Test File
## Read subjects in test group file and assign column names
test <- read.table(file="test\\x_test.txt")
names(test) <- feature_names

## Assign record numbers to identifer so the correct subject and activity can be assigned
test_recnum <- rownames(test)
test <- cbind(test_recnum=test_recnum, test)

## Read test activity file and assign column names
test_labels <- read.table(file="test\\y_test.txt")
names(test_labels) <- c("Activity_Code")

## Read subject file and assign column names
subject_test <- read.table(file="test\\subject_test.txt")
names(subject_test) <- c("Subject_ID")

## Assign record numbers to identifer so the correct subject can be assigned
subject_recnum <- rownames(subject_test)
subject_test <- cbind(subject_recnum=subject_recnum, subject_test)

## Assign record numbers to identifer so the correct test activity can be assigned
activity_recnum <- rownames(test_labels)
test_labels <- cbind(activity_recnum=activity_recnum, test_labels)

##
test_activity_desc <-sqldf("SELECT test_labels.activity_recnum, test_labels.Activity_Code, activity_labels.Activity from activity_labels inner join test_labels on activity_labels.Activity_Code = test_labels.Activity_Code")

test_activity_c <- merge(x=test_activity_desc, y=test, by.x="activity_recnum", by.y="test_recnum")

test_subject_activity <- merge(x=subject_train, y=test_activity_c, by.x="subject_recnum", by.y="activity_recnum")


## Append Test and Train data frames and drop unneeded columns

train_test_comb <- rbind(test_subject_activity, train_subject_activity)

train_test_final <- subset(train_test_comb, select = -c(subject_recnum, Activity_Code))


## Subset Train / Test data frame for subject, activity, mean and standard deviation
train_test_subset <- subset(train_test_final, select = c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,85,86,87,88,123,124,125,126,127,128,163,164,165,166,167,168,203,204,216,217,229,230,242,243,255,256,268,269,270,271,272,273,296,297,298,347,348,349,350,351,352,426,427,428,429,430,431,454,455,456,505,506,515,518,528,531,532,541,544,545,554,557,558,559,560,561,562,563 ))

##

train_test_mean <- ddply(train_test_final, .(Subject_ID, Activity), colwise(mean))

##  Write out tidy data set with subject, activity, mean and standard deviation columns
write.csv(train_test_subset, file="train_test_mean_stddev.csv")

##  Write out tidy data set with mean by subject, activity
write.csv(train_test_mean, file="train_test_subject_activity_mean.csv")


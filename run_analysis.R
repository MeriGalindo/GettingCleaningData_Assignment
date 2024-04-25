## Load libraries
library(readr)
library(dplyr)
library(utils)
library(tidyr)

## Read downloaded files
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep = "" )
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep = "")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep = "")

train_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep = "" )
train_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep = "")
train_set <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep = "")

variable_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE,sep="")

## Appropriately label the data set with descriptive variable names. 
names(test_activity)[1] <- "activity"
names(train_activity)[1] <- "activity"
names(test_subject)[1] <- "subject"
names(train_subject)[1] <- "subject"

# create a new column with unique descriptive variable names for the 561 measures
variable_names <- mutate(variable_names, V3 = paste(V1,V2, sep = "_"))

names(test_set)[1:561] <- variable_names$V3
names(train_set)[1:561] <- variable_names$V3

## merge each set with cdbind
test_set <- cbind(test_subject,test_activity,test_set)
train_set <- cbind(train_subject, train_activity, train_set)

## Merge the training and the test sets to create one data set.
merged_sets <- rbind(train_set,test_set)

# Extract only the measurements on the mean and standard deviation for each measurement.
mean_summary <- sapply(merged_sets[3:563], mean)
standard_deviation_summary <- sapply(merged_sets[3:563], sd)

## Use descriptive activity names to name the activities in the data set
merged_sets$activity[merged_sets$activity == 1] = "walking"
merged_sets$activity[merged_sets$activity == 2] = "walking_upstairs"
merged_sets$activity[merged_sets$activity == 3] = "walking_downstairs"
merged_sets$activity[merged_sets$activity == 4] = "sitting"
merged_sets$activity[merged_sets$activity == 5] = "standing"
merged_sets$activity[merged_sets$activity == 6] = "laying"

## Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
tidy_dataset <- merged_sets %>%
    dplyr::group_by(activity, subject)%>%
    dplyr::summarise(across(all_of(variable_names$V3),mean))

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

## merge each set with cdbind
test_set <- cbind(test_subject,test_activity,test_set)
train_set <- cbind(train_subject, train_activity, train_set)

## Merge the training and the test sets to create one data set.
merged_sets <- rbind(train_set,test_set)

## Appropriately label the data set with descriptive variable names. 
variable_names_full <- append(c("subject","activity"),variable_names$V2)
names(merged_sets) <- variable_names_full

# Extract only the measurements on the mean and standard deviation for each measurement.
subject <- grepl("subject", variable_names_full)
activity <- grepl ("activity", variable_names_full)
mean_only <-grepl("mean", variable_names_full)
std_only <- grepl("std", variable_names_full)
mean_std_vector <- mean_only | std_only |subject | activity

mean_std_set <- merged_sets[,mean_std_vector]
new_names <- names(mean_std_set)
measurement_names <- new_names[3:81]

## Use descriptive activity names to name the activities in the data set
mean_std_set$activity[mean_std_set$activity == 1] = "walking"
mean_std_set$activity[mean_std_set$activity == 2] = "walking_upstairs"
mean_std_set$activity[mean_std_set$activity == 3] = "walking_downstairs"
mean_std_set$activity[mean_std_set$activity == 4] = "sitting"
mean_std_set$activity[mean_std_set$activity == 5] = "standing"
mean_std_set$activity[mean_std_set$activity == 6] = "laying"

## Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
tidy_dataset <- mean_std_set %>%
    dplyr::group_by(activity, subject)%>%
    dplyr::summarise(across(all_of(measurement_names),mean))

## extract the data data set as a txt file created with write.table() using row.names=FALSE
write.table(tidy_dataset, file="tidy_dataset.txt",row.names = FALSE, sep = "") 

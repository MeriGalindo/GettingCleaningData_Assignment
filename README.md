=====================================================
# Getting and Cleaning Data Course Project
Repo for the programming assignment of Course 3 of the Data Science Specialization Johns Hopkins
2024-04-24
Meri Galindo
======================================================
Scripts used and brief explanation on how they work and how they are connected:

- Load libraries\
   library(readr)\
   library(dplyr)\
   library(utils)\
   library(tidyr)

- Read downloaded files using the read.table function (from utils library)\
   test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep = "" )\
   test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep = "")\
   test_set <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep = "")

   train_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep = "" )\
   train_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep = "")\
   train_set <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep = "")

   variable_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE,sep="")

- Merge each set with cdbind so that the first column is the subject, the second column the activity and then all the measurements (561). It ends with a total of 563 colums\
test_set <- cbind(test_subject,test_activity,test_set)\
train_set <- cbind(train_subject, train_activity, train_set)

- Merge the training and the test sets with rbins to create one data set with all the subjects. The merged_sets will have 5894 obs and 563 variables\
merged_sets <- rbind(train_set,test_set)

- Appropriately label the data set with descriptive variable names. Use the features.txt file to gather the names of the measurements and add the subject and activity columns\
variable_names_full <- append(c("subject","activity"),variable_names$V2)\
names(merged_sets) <- variable_names_full

- Extract only the measurements on the mean and standard deviation for each measurement. 
- Use grepl to extract the columns that contain subject, activity, mean and std in their names\
subject <- grepl("subject", variable_names_full)\
activity <- grepl ("activity", variable_names_full)\
mean_only <-grepl("mean", variable_names_full)\
std_only <- grepl("std", variable_names_full)\
mean_std_vector <- mean_only | std_only |subject | activity
- reate a new set containing only these columns\
mean_std_set <- merged_sets[,mean_std_vector]\
new_names <- names(mean_std_set)
- create a vector to extract only measurement names\
measurement_names <- new_names[3:81]

- Use descriptive activity names to name the activities in the data set\
mean_std_set$activity[mean_std_set$activity == 1] = "walking"\
mean_std_set$activity[mean_std_set$activity == 2] = "walking_upstairs"\
mean_std_set$activity[mean_std_set$activity == 3] = "walking_downstairs"\
mean_std_set$activity[mean_std_set$activity == 4] = "sitting"\
mean_std_set$activity[mean_std_set$activity == 5] = "standing"\
mean_std_set$activity[mean_std_set$activity == 6] = "laying"

- Create a second, independent tidy data set with the average of each variable for each activity and each subject.\
Use group by to group by 1) activity and 2) subject\
Summarise only the columns with measurements\
tidy_dataset <- mean_std_set %>%\
    dplyr::group_by(activity, subject)%>%\
    dplyr::summarise(across(all_of(measurement_names),mean))


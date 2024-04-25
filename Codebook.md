================================================ 
Codebook \
Version 2.1
================================================
The data was downloaded from the url give by Coursera: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
All files are in .txt format

The original dataset included the following files:
- A README.txt file from the dataset was used to understand the data and prepare the new codebook
- A features.txt file contains the names of the variables (561 variables)
- A features_info.txt contains the explanations of what each of these variables are
- A activity_labels.txt files contain the names of the 6 activities evaluated:\
    1 WALKING\
    2 WALKING_UPSTAIRS\
    3 WALKING_DOWNSTAIRS\
    4 SITTING\
    5 STANDING\
    6 LAYING
- There are 2 folders, one for the test data and another for the train data. Each set has the same subfolder and files with the same file names\
  'subject_test.txt': Subject identification for the set, there are 30 subjects on the study.\
  'train/X_train.txt': Training set.\
  'train/y_train.txt': Training labels.\
  'test/X_test.txt': Test set.\
  'test/y_test.txt': Test labels.
  - folder with inertial signals for the 3 axis (x, y and z) of 
      - body acceleration
      - angular velocity
      - total acceleration for both 

To perform the assignment the following workflow was used:
1. Load libraries to be used: readr, dplyr, utils and tidyr
2. Read downloaded files using read.table
3. Merge the 3 test tables and the 3 train tables with cbind creating a test set and a train set
4. Merge the test and train sets with rbind
5. Appropriately label the data set with descriptive variable names
6. Extract only the measurements on the mean and standard deviation for each measurement, creating a new set called mean_std_set
7. Use descriptive activity names to name the activities in the data set: change the numbers for the verbs using the activity labels
8. From the previous set, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## The final independent tidy data set is called *tidy_dataset*:
- It contains 54 observations and 79 averaged measurements grouped by activity and subject.
- The measurement names are located in the vector measurement_names

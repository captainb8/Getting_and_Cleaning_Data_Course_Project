# CodeBook

This code book provides info about the data used by, and transformations made by the R script found in this repo (run_analysis.R).

## Original Data
* Source data (zipped): https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Source data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Original Data Overview
The following was taken from the description link above:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Original Data Used

The following files from the original data are used by the R script:
- features.txt
- activity_labels.txt
- train/X_train.txt
- train/y_train.txt
- train/subject_train.txt
- test/X_test.txt
- test/y_test.txt
- test/subject_test.txt

Further info about these files can be found in the README file contained in the above referenced zip file.

## Transformation details

After downloading and unzipping the source data, the R script performs the following high level tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


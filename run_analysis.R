## PROJECT REQUIREMENTS
# Create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# assumes working directory is already set

## DOWNLOAD & UNZIP DATA (this assumes data has not previously been obtained)
# download data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "dataset.zip", method="curl")
#unzip file
unzip("dataset.zip")


## 0. LOAD DATA
# load activity data
ActivityTestData <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
ActivityTrainData <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
# load subject data
SubjectTestData  <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
SubjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
# load features data
FeaturesTestData  <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
FeaturesTrainData <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)


## 1. MERGE TRAINING & TEST DATA
# merge data sets
ActivityData <- rbind(ActivityTestData, ActivityTrainData)
SubjectData <- rbind(SubjectTestData, SubjectTrainData)
FeaturesData <- rbind(FeaturesTestData, FeaturesTrainData)

# assign names to variables
names(ActivityData)<- c("activity")
names(SubjectData)<-c("subject")
FeaturesNamesData <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
names(FeaturesData)<- FeaturesNamesData$V2

#combine subject & activity data
CombinedData <- cbind(SubjectData, ActivityData)
# now combine with features data
FinalData <- cbind(CombinedData, FeaturesData)


## 2. EXTRACT MEASUREMENTS WE CARE ABOUT
# get variable names with mean or std in them
varNames <- FeaturesNamesData$V2[grep("mean|std", FeaturesNamesData$V2)]
varNames <- c("subject", "activity", as.character(varNames))
# subset the data based on the variable names we care about
FinalData <- subset(FinalData, select = varNames)


## 3. SET DESCRIPTIVE ACTIVITY NAMES
# load activity lables
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
# join activity labels
FinalData <- merge(FinalData, ActivityLabels, by.x = "activity", by.y = "V1", all = FALSE)
# update activity variable to descriptive name
FinalData$activity <- FinalData$V2
# drop joined column
FinalData$V2 <- NULL


## 4. SET DESCRIPTIVE VARIABLE NAMES
names(FinalData)<-gsub("^t", "time", names(FinalData))
names(FinalData)<-gsub("^f", "frequency", names(FinalData))
names(FinalData)<-gsub("Acc", "Accelerometer", names(FinalData))
names(FinalData)<-gsub("Gyro", "Gyroscope", names(FinalData))
names(FinalData)<-gsub("Mag", "Magnitude", names(FinalData))
names(FinalData)<-gsub("BodyBody", "Body", names(FinalData))


## 5. CREATE SECOND DATA SET WITH AVG OF EACH VARIABLE BY ACTIVITY & SUBJECT
FinalDataAvg <- aggregate(. ~subject + activity, FinalData, mean)
# sort it by subject and activity
FinalDataAvg <- FinalDataAvg[order(FinalDataAvg$subject,FinalDataAvg$activity),]
# output tidy data set to a txt file
write.table(FinalDataAvg, file = "FinalDataAvg.txt", row.name = FALSE)

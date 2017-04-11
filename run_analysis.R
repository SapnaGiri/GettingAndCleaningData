#load required packages
library(dplyr)

#Read activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity <- as.character(activity_labels$V2)

#Read features.txt
features <- read.table("UCI HAR Dataset/features.txt")


#Read training data
#subject
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c("subject")

#y_train
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#create data frame activity_train which contains activity labels for data in y_train
activity_train <- data.frame(activity = activity[y_train$V1])

#X_train
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(X_train) <- features$V2

#traindata -- club all training data sets
traindata <- cbind(subject_train, activity_train, X_train)

#Read test data
#subject
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c("subject")

#y_test
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#create data frame activity_test which contains activity labels for data in y_test
activity_test <- data.frame(activity = activity[y_test$V1])

#X_test
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(X_test) <- features$V2

#testdata -- club all test data
testdata <- cbind(subject_test, activity_test, X_test)

# 1. Merges the training and the test sets to create one data set.
alldata <- rbind(traindata, testdata)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
allcolumnnames <- names(alldata)

# find all columns which are mean and std measurements
meanandstdcolumns <- grep("mean()|std()", allcolumnnames, value = T)

#fetch data containing only the mean and std measurement columns along with subject identifier and activity names
meanAndStdData <- alldata[, c("subject", "activity", meanandstdcolumns)]


#create a data frame from meanAndStdData containing the average of each variable for each activity and each subject
#first group data by subject and activity
by_subject_activity <- group_by(meanAndStdData, subject, activity)

#use summarize to find the mean of each variable for each subject and activity
variableMeansBySubjectActivity <- summarize_each(by_subject_activity, funs(mean(., na.rm = T)))

#write final dataset to txt file
write.table(variableMeansBySubjectActivity,"GettingAndCleaningData.txt", row.names = F, col.names = F)




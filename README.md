###Getting and Cleaning Data Course Assignment
##Goal

Companies like FitBit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The aim of the project is to clean and extract usable data from the above zip file. R script called run_analysis.R that does the following:

    1) Merges the training and the test sets to create one data set.
    2) Extracts only the measurements on the mean and standard deviation for each measurement.
    3) Uses descriptive activity names to name the activities in the data set
    4) Appropriately labels the data set with descriptive variable names.
    5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In this repository, you find:

    run_analysis.R : the R-code run on the data set

    Tidy.txt : the clean data extracted from the original data using run_analysis.R

    CodeBook.md : the CodeBook reference to the variables in Tidy.txt

    README.md : the analysis of the code in run_analysis.R

    

###Getting Started

##Basic Assumption

The R code in run_analysis.R proceeds under the assumption that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is downloaded and extracted in the R Home Directory.

##Libraries Used

The libraries used in this operation are data.table and dplyr. We prefer data.table as it is efficient in handling large data as tables. dplyr is used to aggregate variables to create the tidy data.

library(data.table)
library(dplyr)

##Read Supporting Metadata

The supporting metadata in this data are the name of the features and the name of the activities. They are loaded into variables featureNames and activityLabels.

featureNames <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/features.txt")
activityLabels <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Format training and test data sets

Both training and test data sets are split up into subject, activity and features. They are present in three different files.

##Read training data

subjectTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

##Read test data

subjectTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

###Part 1 - Merge the training and the test sets to create one data set

We can use combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in subject, activity and features.

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

##Naming the columns

The columns in the features data set can be named from the metadata in featureNames

colnames(features) <- t(featureNames[2])

##Merge the data

The data in features,activity and subject are merged and the complete data is now stored in completeData.

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

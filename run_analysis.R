#Loading libraries
library(data.table)
library(dplyr)

#Read Supporting Metadata
featureNames <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/features.txt")
activityLabels <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Format train data
#The data is split up into subject, activity and features

#Read train data
subjectTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

#Read test data
subjectTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("D:/DSS/Getting Cleaning Data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

#Part 1 - Merge the training and the test sets to create one data set
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#Name the column names from the features file in variable featureNames
colnames(features) <- t(featureNames[2])

#Add activity and subject as a column to features
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

#Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#Adding activity and subject columns
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
extractedData <- completeData[,requiredColumns]

#Part 3 - Uses descriptive activity names to name the activities in the data set
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

#Set the activity variable in the data as a factor
extractedData$Activity <- as.factor(extractedData$Activity)

#Part 4 - Appropriately labels the data set with descriptive variable names

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#Part 5 - From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
#Set the subject variable in the data as a factor
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#Create tidyData as a set with average for each activity and subject
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)

#Order tidayData according to subject and activity
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

#Write tidyData into a text file
write.table(tidyData, file = "D:/DSS/Getting Cleaning Data/UCI HAR Dataset/Tidy.txt", row.names = FALSE)

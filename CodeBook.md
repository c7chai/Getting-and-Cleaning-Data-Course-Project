##CodeBook

This file describes the variables, data and transformations used in run_analysis.R script to clean up the data.

##Dataset Used

The data is obtained from "Human Activity Recognition Using Smartphones Data Set". The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data set used can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

##Input Data Set

The input data containts the following data files:

    1)X_train.txt contains variable features that are intended for training.
    
    2)y_train.txt contains the activities corresponding to X_train.txt.
    
    3)subject_train.txt contains information on the subjects from whom data is collected.
    
    4)X_test.txt contains variable features that are intended for testing.
    
    5)y_test.txt contains the activities corresponding to X_test.txt.
    
    6)subject_test.txt contains information on the subjects from whom data is collected.
    
    7)activity_labels.txt contains metadata on the different types of activities.
    
    8)features.txt contains the name of the features in the data sets.

##Transformations

Following are the transformations that were performed on the input dataset:


    1)X_train.txt is read into featuresTrain.
    
    2)y_train.txt is read into activityTrain.
    
    3)subject_train.txt is read into subjectTrain.
    
    4)X_test.txt is read into featuresTest.
    
    5)y_test.txt is read into activityTest.
    
    6)subject_test.txt is read into subjectTest.
    
    7)features.txt is read into featureNames.
    
    8)activity_labels.txt is read into activityLabels.
    
    9)The subjects in training and test set data are merged to form subject.
    
    10)The activities in training and test set data are merged to form activity.
    
    11)The features of test and training are merged to form features.
    
    12)The name of the features are set in features from featureNames.
    
    13)features, activity and subject are merged to form completeData.
    
    14)Indices of columns that contain std or mean, activity and subject are taken into requiredColumns .
    
    15)extractedData is created with data from columns in requiredColumns.
    
    16)Activity column in extractedData is updated with descriptive names of activities taken from activityLabels. Activity column is expressed as a factor variable.
    
    17)Acronyms in variable names in extractedData, like 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and 'Frequency'.
    
    18)tidyData is created as a set with average for each activity and subject of extractedData. Entries in tidyData are ordered based on activity and subject.
    
    19)Data in tidyData is written into Tidy.txt.

##Output Data Set

The output data Tidy.txt is a a space-delimited value file. The header line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files. The headers are relabeled appropriately for better understanding. 

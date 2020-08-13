# run_analysis.R

## Setting up libraries and metadata

#install.packages("dplyr")
#install.packages("data.table)

#Load packages
library(data.table)
library(dplyr)

#set working directory
setwd("~/RStudioESM/UCI HAR Dataset")

#read supporting metadata and designate variables

featureNames <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)

## Format training and test datasets

#read training data

subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
activityTrain <- read.table("train/y_train.txt", header = FALSE)
featuresTrain <- read.table("train/X_train.txt", header = FALSE)

#read test data

subjectTest <- read.table("test/subject_test.txt", header = FALSE)
activityTest <- read.table("test/y_test.txt", header = FALSE)
featuresTest <- read.table("test/X_test.txt", header = FALSE)

## Merge training and test datasets to create one combined dataset

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#name the columns in the features dataset

colnames(features) <- t(featureNames[2])

#merge data in features, activity and subject to store in completeData

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

## Extract only measurements of mean and standard deviation for each measurement

#extract column indicies that include mean or std

columnsWithMeanorSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#add activity and subject columns to list and look at dimension of completeData

requiredColumns <- c(columnsWithMeanorSTD, 562, 563)
dim(completeData)

#create extractedData and look at the dimensions once again

extractedData <- completeData[,requiredColumns]
dim(extractedData)

## Use descriptive activity names to designate activities in dataset
#change type from numeric to character to accept activity names from activityLabels.txt

extractedData$Activity <- as.character(extractedData$Activity)
        for (i in 1:6){
        extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
        }

#factor the activity variable

extractedData$Activity <- as.factor(extractedData$Activity)

## Label the dataset with the descriptive variable names in extractedData

names(extractedData)

#replace acronyms using gsub with full descriptive name

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData))
names(extractedData)<-gsub("-std()", "STD", names(extractedData))
names(extractedData)<-gsub("-freq", "Frequency", names(extractedData))
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#view edited variable names

names(extractedData)

## Create second, independent and tidy dataset with average of each variable for each acticity and each subject

#set Subject as factor variable

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#create tidyData as new dataset

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

## Check variable names in new dataset

str(tidyData)
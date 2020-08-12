# Getting-and-Cleaning-Data-Week-4-Course-Project
Week 4 Assignment for Getting and Cleaning Data

Johns Hopkins Data Science Specialization: Coursuera Week 4 Getting and Cleaning Data Course Project

##Soure Data

The data used for this project represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The variables in the data X are sensor signals measured with waist-mounted smartphones carried by 30 volunteer subjects. The variable in the data Y indicate the activity type the subjects performed during each recording.

A full description from where the data was obtained can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

An R script called run_analysis.R was created in this repository to perform the following functions:

1. Merges the training and the tes tsets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive acticity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Code Explanation and New Dataset

The code has combined the training dataset and test dataset, extracted the partial variables of mean and standard deviation to create a separate dataset with the averages of each variable per performed activity. The new dataset will contain variables calculated based on mean and standard deviation which each row corresponding to an average for each activity type.

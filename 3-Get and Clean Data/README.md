# Project Overview
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once data is prepared in the working directory, R script called `run_analysis.R` can be run to process the data.
More information about the data can be found in the [CodeBook.md](Get-CleanData/CodeBook.md)

## Process
1. Merges the training and the test sets to create one data set.Appropriately labels the data set with descriptive variable names.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Output
A txt file name `tidydata.txt` stored in working directory.

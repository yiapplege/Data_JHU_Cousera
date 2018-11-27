#Getting & Cleaning Data
#Assignment for Week 4
#Author: Yige
#Date: Nov.16, 2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/3_4/UCI HAR Dataset")

#1. Merges the train and the test sets to create one data set. 
#Appropriately labels the data set with descriptive variable names.
library(dplyr)
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")
#70% train
trainset <- read.table("train/X_train.txt")
colnames(trainset) <- features$V2
trainlabel <- read.table("train/y_train.txt")
colnames(trainlabel) <- c("activity")
trainsub <- read.table("train/subject_train.txt")
colnames(trainsub) <- c("subjectID")
train <- cbind(trainsub,trainlabel,trainset)
rm(trainset,trainlabel,trainsub)

#30% test
testset <- read.table("test/X_test.txt")
colnames(testset) <- features$V2
testlabel <- read.table("test/y_test.txt")
colnames(testlabel) <- c("activity")
testsub <- read.table("test/subject_test.txt")
colnames(testsub) <- c("subjectID")
test <- cbind(testsub,testlabel,testset)
rm(testset,testlabel,testsub)

#dataset <- rbind(trainset,testset)
dat <- rbind(test,train)
dat <- dat[order(dat$subjectID,dat$activity),]

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
ext_meanstd <- grep("mean()|std()",features$V2)
dat_meanstd <- dat[,c(1,2,ext_meanstd+2)]


#3. Uses descriptive activity names to name the activities in the data set
dat_meanstd$activityname <- factor(dat$activity,labels = activities$V2)
dat[,c(1,2,564,3:563)]


#4. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
library(reshape2)

datmelted <- melt(dat_meanstd,id.vars = c("subjectID","activity","activityname"))
datset <- dcast(datmelted, subjectID + activity ~ variable,mean)

write.table(datset, file ="tidydata.txt", row.name=FALSE)

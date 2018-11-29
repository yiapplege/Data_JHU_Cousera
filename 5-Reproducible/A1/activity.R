#Reproducible Research
#Assignment 1
#Author: Yige
#Date: Nov.23,2018

rm(list=ls())
library(ggplot2)
#set your working directory before start
setwd("~/Desktop/Data Science @Coursera/Assignments/5_2")

#download data
if (!file.exists("activity.zip")){
      download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", "activity.zip", method="curl")
}
unzip("activity.zip")
file.remove("activity.zip")

#read data
dat <- read.csv("activity.csv",header = TRUE)
dat$steps <- as.numeric(dat$steps)
dat$date <- as.Date(dat$date,"%Y-%m-%d")
str(dat)

#mean total number of steps taken per day========
dailystep <- aggregate(steps~date,dat,sum)
qplot(steps,data = dailystep,bins=10) +
      geom_rug(size=0.2) +
      labs(x="Daily Total Steps",y="Frequency") +
      ggtitle("Histogram of Daily Steps") +
      theme(plot.title = element_text(hjust=0.5))

summary(dailystep$steps)

#average daily activity pattern========
interstep <- aggregate(steps~interval,dat,mean)
ggplot(interstep,aes(interval,steps)) + 
      geom_line() +
      labs(x="Average Steps of Each Interval",y="Steps") +
      ggtitle("Average Daily Activity Pattern") +
      theme(plot.title = element_text(hjust=0.5))

interstep[which.max(interstep$steps),]

#imputing missing values========
table(is.na(dat$steps)) #True if missing

#fill missing value by interval mean
dat2 <- dat
for(i in 1:nrow(dat2)){
      if(is.na(dat2$steps[i])==TRUE){
            dat2$steps[i] = interstep$steps[which(interstep$interval==dat2$interval[i])]
      }
}

table(is.na(dat2$steps))

dailystep2 <- aggregate(steps~date,dat2,sum)
qplot(steps,data = dailystep2,bins=10) +
      geom_rug(size=0.2) +
      labs(x="Daily Total Steps",y="Frequency") +
      ggtitle("Histogram of Daily Steps") +
      theme(plot.title = element_text(hjust=0.5))
summary(dailystep2$steps)

#differences between weekdays and weekends========
#library(dplyr)
#dat2 <- mutate(dat2,weekday = weekdays(date))
#dat2 <- mutate(dat2,daytype = factor(weekday=="Saturday"|weekday=="Sunday",labels = c("weekday","weekend")))

dat2$day <- weekdays(dat2$date)
dat2$daytyppe <- factor(dat2$weekday=="Saturday"|dat2$weekday=="Sunday",labels = c("weekday","weekend"))

interstep2 <- aggregate(steps~interval+daytype,dat2,mean)
ggplot(interstep2,aes(interval,steps,color=daytype)) +
      geom_line() +
      facet_grid(daytype~.) +
      labs(x="Average Steps of Each Interval",y="Steps") +
      ggtitle("Activity Pattern of Weekday & Weekend") +
      theme(plot.title = element_text(hjust=0.5))


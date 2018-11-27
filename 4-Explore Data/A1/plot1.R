#Exploratory Data Analysis
#Assignment 1
#Author: Yige
#Date: Nov.19,2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/4_1")
dat <- read.table("household_power_consumption.txt",sep = ";",dec=".",header = TRUE, na.string="?")
dat <- subset(dat,Date %in% c("1/2/2007","2/2/2007"))
dat$Global_active_power<-as.numeric(dat$Global_active_power)

#plot1
png(filename = "plot1.png",width =480,height=480)
hist(dat$Global_active_power,main = "Global Active Power", col="red",xlab="Global Active Power (kilowatts)")
dev.off()








#Exploratory Data Analysis
#Assignment 1
#Author: Yige
#Date: Nov.19,2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/4_1")
dat <- read.table("household_power_consumption.txt",sep = ";",dec=".",header = TRUE, na.string="?")
dat <- subset(dat,Date %in% c("1/2/2007","2/2/2007"))
dat$Global_active_power<-as.numeric(dat$Global_active_power)

# convert time format
dat$DateTime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S", tz="UTC") 

#plot2
png(filename = "plot2.png",width = 480,height=480)
plot(dat$DateTime, dat$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

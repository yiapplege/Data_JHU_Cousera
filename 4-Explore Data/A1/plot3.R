#Exploratory Data Analysis
#Assignment 1
#Author: Yige
#Date: Nov.19,2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/4_1")
dat <- read.table("household_power_consumption.txt",sep = ";",dec=".",header = TRUE, na.string="?")
dat <- subset(dat,Date %in% c("1/2/2007","2/2/2007"))
dat$Sub_metering_1<-as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2<-as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3<-as.numeric(dat$Sub_metering_3)
dat$DateTime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#plot3
png(filename = "plot3.png",width = 480,height=480)
plot(dat$DateTime,dat$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub Metering")
lines(dat$DateTime,dat$Sub_metering_2,type="l",col="red")
lines(dat$DateTime,dat$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering1","Sub_metering2","Sub_metering3"),lty="solid",col = c("black","red","blue"))
dev.off()

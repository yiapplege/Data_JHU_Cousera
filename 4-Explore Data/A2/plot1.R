#Exploratory Data Analysis
#Assignment 2
#Author: Yige
#Date: Nov.26,2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/4_4")

#read data
NEI <- readRDS("summarySCC_PM25.rds") #national emission inventory
SCC <- readRDS("Source_Classification_Code.rds") #source classification code
NEI$Emissions <- as.numeric(NEI$Emissions)

total <- tapply(NEI$Emissions,NEI$year,sum)

png(filename = "plot1.png",width = 480,height=480)
plot(total,main="Total PM2.5 Emission in US",ylab = "Emission (ton)",
     xlab="Year",xaxt="n",pch=19)
lines(total,lty=2,col="lightblue",lwd=1.5)
axis(side=1,at=seq(1,4,by=1),labels = c(1999,2002,2005,2008))
dev.off()

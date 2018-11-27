#Exploratory Data Analysis
#Assignment 2
#Author: Yige
#Date: Nov.26,2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/4_4")
library(dplyr)
library(ggplot2)

#read data
NEI <- readRDS("summarySCC_PM25.rds") #national emission inventory
SCC <- readRDS("Source_Classification_Code.rds") #source classification code
NEI$Emissions <- as.numeric(NEI$Emissions)
btm <- filter(NEI,fips=="24510") 

btmagg <- aggregate(data=btm,Emissions~year+type,sum)

png(filename = "plot3.png",width = 480,height=480)
g <- ggplot(btmagg, aes(x=year,y=Emissions,color=type))
g + geom_point(size=2) + geom_line(linetype=2,lwd=0.5) +
      labs(title="Baltimore Annual PM2.5 Emission by Type",
           y="Emissions (ton)")
dev.off()

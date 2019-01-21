#Reproducible Research
#Assignment 2
#Author: Yige
#Date: Nov.29,2018

rm(list=ls())

#set the working directory before start
setwd("~/Desktop/Data Science @Coursera/Assignments/5_4")
library(reshape2)
library(ggplot2)

#download data
if (!file.exists("stormdata.zip")){
      download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", 
                    "stormdata.zip", method="curl")
}

storm <- read.csv("stormdata.zip",header = TRUE)
names(storm)

dat <- storm[,c("EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")]
rm(storm)

# which types of events(EVTYPE variable) are most harmful with respect to population health?
pubH1 <- aggregate(FATALITIES ~ EVTYPE, dat,sum)
pubH1 <- pubH1[order(-pubH1$FATALITIES),][1:10,]
pubH1$EVTYPE <- factor(pubH1$EVTYPE,levels = pubH1$EVTYPE)
ggplot(data=pubH1,aes(x=EVTYPE,y=FATALITIES)) +
      geom_bar(stat="identity",fill="red") +
      labs(x="Event Type",y="Fatalities") +
      ggtitle("Top 10 Fatal Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))

pubH2 <- aggregate(INJURIES ~ EVTYPE,dat,sum)
pubH2 <- pubH2[order(-pubH2$INJURIES),][1:10,]
pubH2$EVTYPE <- factor(pubH2$EVTYPE,levels = pubH2$EVTYPE)
ggplot(data=pubH2,aes(x=EVTYPE,y=INJURIES)) +
      geom_bar(stat="identity",fill="darkblue") +
      labs(x="Event Type",y="Injuries") +
      ggtitle("Top 10 Injury-prone Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))


pubH1 <- aggregate(FATALITIES ~ EVTYPE, dat,sum)
pubH2 <- aggregate(INJURIES ~ EVTYPE,dat,sum)
pubH <- merge(pubH1,pubH2,by="EVTYPE")
pubH$total <- pubH$FATALITIES+pubH$INJURIES
pubH <- pubH[order(-pubH$total),][1:10,]
pubH <- melt(pubH[1:10,1:3],id="EVTYPE",value.name = "count")
ggplot(pubH,aes(x=reorder(EVTYPE,-count),y=count,fill=variable)) +
      scale_fill_manual(values = c("brown","darkgoldenrod3"),labels=c("Fatalites","Injuries")) +
      geom_bar(stat = "identity") +
      labs(x="Event Type",y="Population") +
      ggtitle("Top 10 Harmful Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))
      

#which types of events have the greatest economic consequences?
#EXP = exponent, https://rpubs.com/flyingdisc/PROPDMGEXP
summary(dat$PROPDMGEXP)
dat$propdc[dat$PROPDMGEXP %in% c("","-","?")] <- 0
dat$propdc[dat$PROPDMGEXP=="+"] <- 1
dat$propdc[dat$PROPDMGEXP %in% c(0:8)] <- 10
dat$propdc[dat$PROPDMGEXP %in% c("h","H")] <- 100
dat$propdc[dat$PROPDMGEXP=="K"] <- 1000
dat$propdc[dat$PROPDMGEXP %in% c("m","M")] <- 1000000
dat$propdc[dat$PROPDMGEXP=="B"] <- 1000000000

dat$PROPDMG <-as.numeric(dat$PROPDMG)
dat$propdc <- as.numeric(dat$propdc)
dat$propdc <- dat$PROPDMG*dat$propdc


dat$cropdc[dat$CROPDMGEXP %in% c("","?")] <- 0
dat$cropdc[dat$CROPDMGEXP %in% c("0","2")] <- 10
dat$cropdc[dat$CROPDMGEXP %in% c("k","K")] <- 1000
dat$cropdc[dat$CROPDMGEXP %in% c("m","M")] <- 1000000
dat$cropdc[dat$CROPDMGEXP=="B"] <- 1000000000

dat$CROPDMG <-as.numeric(dat$CROPDMG)
dat$cropdc <- as.numeric(dat$cropdc)
dat$cropdc <- dat$CROPDMG*dat$cropdc


dmg1 <- aggregate(propdc~EVTYPE,dat,sum)
dmg2 <- aggregate(cropdc~EVTYPE,dat,sum)
topdmg <- merge(dmg1,dmg2,by="EVTYPE")
topdmg$total <- topdmg$propdc+topdmg$cropdc
topdmg <- topdmg[order(-topdmg$total),][1:10,]
topdmg <- melt(topdmg[1:10,1:3],id="EVTYPE",value.name = "cost")
ggplot(topdmg,aes(x=reorder(EVTYPE,-cost),y=cost,fill=variable)) +
      scale_fill_manual(values = c("olivedrab3","burlywood4"),labels=c("Property","Crop")) +
      geom_bar(stat = "identity") +
      labs(x="Event Type",y="Total Damage Cost ($)") +
      ggtitle("Top 10 Damage Cost Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))


#--------------------------
topdmg <- aggregate(totaldmg ~ EVTYPE,dat,sum)
topdmg <- topdmg[order(-topdmg[,2]),][1:10,]

topdmg$EVTYPE <- factor(topdmg$EVTYPE,levels = topdmg$EVTYPE)
ggplot(data=topdmg,aes(x=EVTYPE,y=totaldmg)) +
      geom_bar(stat="identity",fill="darkgreen") +
      labs(x="Event Type",y="Total Damage Cost ($)") +
      ggtitle("Top 10 Economic Lost Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))

pubH$total <- pubH$FATALITIES+pubH$INJURIES
pubH <- pubH[order(-pubH$total),][1:10,]
pubH <- melt(pubH[1:10,1:3],id="EVTYPE",value.name = "count")
ggplot(pubH,aes(x=reorder(EVTYPE,-count),y=count,fill=variable)) +
      scale_fill_manual(values = c("brown","darkgoldenrod3")) +
      geom_bar(stat = "identity") +
      labs(x="Event Type",y="Fatalities") +
      ggtitle("Top 10 Harmful Weather Event") +
      theme(plot.title = element_text(hjust=0.5),
            axis.text.x = element_text(angle = 45,hjust=1))

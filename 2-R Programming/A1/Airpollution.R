#R Programming
#Assignment for Week 2
#Author: Yige
#Date: Nov.5, 2018

rm(list=ls())
#Part 1
pollutantmean<-function(directory,pollutant,id=1:332){
      library(readr)
      setwd(directory)
#read data
      files<-list.files(directory, full.names = TRUE)
      dat<-data.frame()
      for(i in id){
            dat <- rbind(dat,read.csv(files[i]))
      }
#pollutant
      mean(dat[,pollutant],na.rm = TRUE)
}

#TEST
pollutantmean("/Users/yige/Desktop/Data Science @Coursera/Assignments/2_1/specdata","sulfate",1:10)
pollutantmean("/Users/yige/Desktop/Data Science @Coursera/Assignments/2_1/specdata","nitrate",70:72)

#Part 2
complete<-function(directory,id=1:332){
      library(readr)
      setwd(directory)
#read data
      files<-list.files(directory, full.names = TRUE)
      totalobs<-data.frame()  
      for(i in id){
            dat<-read.csv(files[i])
            nobs<-sum(complete.cases(dat))
            obs<-data.frame(i,nobs)
            totalobs<-rbind(totalobs,obs)
      }
      colnames(totalobs)<-c("id","nobs")
      return(totalobs)
}
#TEST
complete("/Users/yige/Desktop/Data Science @Coursera/Assignments/2_1/specdata",c(2,4,8,10,12))
complete("/Users/yige/Desktop/Data Science @Coursera/Assignments/2_1/specdata",30:25)

#Part 3
corr <- function(directory, threshold=0){
      setwd(directory)
      files <- list.files(directory, full.names = TRUE)
      correlation <- vector(mode = "numeric", length = 0)

      for(i in 1:length(files)){
            dat <-read.csv(files[i]) 
            
            dat<-na.omit(dat)
            
            if(nrow(dat) > threshold){
                  correlation<-c(correlation,cor(dat$sulfate,dat$nitrate))
            }
      }
      correlation
}
#TEST
cr<-corr("/Users/yige/Desktop/Data Science @Coursera/Assignments/2_1/specdata",150)
head(cr)

#R Programming
#Assignment for Week 4
#Author: Yige
#Date: Nov.6, 2018

rm(list=ls())
setwd("~/Desktop/Data Science @Coursera/Assignments/2_3")

#1 plot the 30-day mortality rates for heart attack
outcome <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
names(outcome)
ncol(outcome)
nrow(outcome)

deathrates <- as.numeric(outcome[,11])
hist(deathrates)


#2 function to find best hosipital in a state
best <- function(state,outcome){
      setwd("~/Desktop/Data Science @Coursera/Assignments/2_3")
      dat <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
      dat <- dat[,c(1:10,11,17,23)] 
      #dat[,c(11,12,13)] <- as.numeric(dat[,c(11,12,13)])
      #colnames(dat)[c(11,12,13)] <- c("heart attack","heart failure","pneumonia")
      #subset hospital info & 30 day death rate of "heart attack","heart failure","pneumonia"
      
      if(!state %in% dat$State){
            stop("invalid state")
      }
      else if(!outcome %in% c("heart attack","heart failure","pneumonia")){
            stop("invalid outcome")
      }
            
      switch(outcome,'heart attack'={col =11},'heart failure'={col=12},
                   'pneumonia'={col=13})
      dat[, col] = as.numeric(dat[, col])
      hop_state <- dat[dat$State == state,c(2,col)]
      hop_state <- na.omit(hop_state)
      hop_state <- hop_state[order(hop_state[,2],hop_state[,1]),]
      hop_state[1,1]
      #hop_state[which.min(hop_state[,2]), 1]

}

#TEST
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hear attack")

#3 Ranking hospital by outcome in a state
rankhospital <- function(state, outcome, num = "best"){
      setwd("~/Desktop/Data Science @Coursera/Assignments/2_3")
      dat <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
      dat <- dat[,c(1:10,11,17,23)] 
      if(!state %in% dat$State){
            stop("invalid state")
      }
      else if(!outcome %in% c("heart attack","heart failure","pneumonia")){
            stop("invalid outcome")
      }
      
      switch(outcome,'heart attack'={col =11},'heart failure'={col=12},
             'pneumonia'={col=13})
      dat[, col] = as.numeric(dat[, col])
      dat_state <- dat[dat$State == state,c(2,col)]
      dat_state <- na.omit(dat_state)
      nhospital <- nrow(dat_state)
      switch(num,'best'={num=1},'worst'={num=nhospital})
      if(num > nhospital){ return(NA) }
      dat_state <- dat_state[order(dat_state[,2],dat_state[,1]),]
      dat_state[num,1]
}

#TEST
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

#4 Ranking hospital in all states
rankall <- function(outcome,num){
      setwd("~/Desktop/Data Science @Coursera/Assignments/2_3")
      dat <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
      
      switch(outcome,'heart attack'={col =11},'heart failure'={col=17},
             'pneumonia'={col=23},stop("invalid outcome"))
      dat[, col] = as.numeric(dat[, col])
      dat <- dat[,c(2,7,col)] #name,state,death rate
      dat <- na.omit(dat)
      
      states=unique(dat$State)
      
      rankstate <- function(state){
            dat_state <- dat[dat$State == state,]
            nhospital <- nrow(dat_state)
            switch(num,'best'={num=1},'worst'={num=nhospital})
            if(num > nhospital){ return(NA) }
            dat_order <- order(dat_state[,3], dat_state[,1]) #order by death rate/name
            name <- dat_state[dat_order,][num,1]
            c(name,state)
      }
      
      result = do.call(rbind, lapply(states, rankstate))
      result = result[order(result[, 2]), ]
      rownames(result) = result[, 2]
      colnames(result) = c("hospital", "state")
      data.frame(result)
}


#TEST
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

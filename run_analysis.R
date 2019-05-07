## Name: Lorenzo Carilho
## email: lorenzocarilho@live.com
## This script downloads the data and then transforms it into a tidy data set


## MAKE SURE THAT YOU SET YOUR OWN WORKING DIRECTORY BEFORE BEGINNING THE ANALYSIS
rm(list = ls())
setwd("~/Data science JHU/Course 3 Getting and cleaning data/Course project")

## Download the data
urlname <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlname, destfile = "./Zipdata")
unzip("./Zipdata")


## The data is stored in flatfiles so read.table() is a good function to load the data into tables in R
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ActivityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
TestVariables <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Now we merge the separate columns of test data into 1 dataframe containing the test data
test1 <- cbind(SubjectTest, ActivityTest)
FullTest <- cbind(test1, TestVariables)

## Now we need to do the same for the train data
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ActivityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
TrainVariables <- read.table("./UCI HAR Dataset/train/X_train.txt")

train1 <- cbind(SubjectTrain, ActivityTrain)
FullTrain <- cbind(train1, TrainVariables)


##Now we merge the training data with the test data
FullData <- rbind(FullTest, FullTrain)

## Now we need to name the first column Subject and the second column Activity
names(FullData)[1] <- "Subject" 
names(FullData)[2] <- "Activity" 

## Name the variables in the dataset
VariableNames <- read.table("./UCI HAR Dataset/features.txt")
VariableNames$V2 <- as.character(VariableNames$V2)
names(FullData)[3:563] <- VariableNames$V2

## Select only mean and std variables
indexmean <- grep("mean", VariableNames$V2)
indexstd <- grep("std", VariableNames$V2)
index <- sort(c(indexmean, indexstd))
index <- index +2
index <- c(1,2,index)
MeanStdData <- FullData[,index]


## Give activities descriptive names and turn Subject into factor variables
ActivitiesName <- read.table("./UCI HAR Dataset/activity_labels.txt")
MeanStdData$Activity <- as.factor(MeanStdData$Activity)
levels(MeanStdData$Activity) <- ActivitiesName$V2
MeanStdData$Subject <- as.character(MeanStdData$Subject)
MeanStdData$Subject <- as.factor(MeanStdData$Subject)


## Give descriptive names to variables
names(MeanStdData) <- sub("^t", "Time", names(MeanStdData))
names(MeanStdData) <- sub("^f", "Freq", names(MeanStdData))
names(MeanStdData) <- sub("-std", "std", names(MeanStdData))
names(MeanStdData) <- sub("-mean", "mean", names(MeanStdData))
names(MeanStdData) <- sub("\\()", "", names(MeanStdData))
names(MeanStdData) <- sub("\\-", "", names(MeanStdData))


## Independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
TidyData <- MeanStdData %>% group_by(Subject, Activity) %>% summarize_all(mean)
write.table(TidyData, file = "./TidyData.txt", row.names = FALSE)






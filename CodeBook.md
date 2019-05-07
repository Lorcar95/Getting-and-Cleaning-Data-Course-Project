---
title: "CodeBook Gettting and Cleaning Data"
author: "Lorenzo Carilho"
date: "5 May 2019"
output:
  html_document:
    keep_md: yes
---

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
A directory containing data from accelerometers from the Samsung Galaxy S smartphone was provided and the goal is to transform this into a Tidy dataset.


###Collection of the raw data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.The raw data was then split into **train** and **test** data.





### Components of the raw data
The raw data consists of:


* a directory containing the train data
* a directory containing the test data
* a README text file
* a text file called activity_labels.txt
* a text file called features.txt
* a text file called features_info.txt

### Note on data
The most important files in the test directory are:

* subject_test.txt  
* X_test.txt  
* y_test.txt    


The most important files in the train directory are:

* subject_train.txt  
* X_train.txt  
* y_train.txt  
 

###Guide to create the tidy data file
To arrive at the requested Tidy dataset we need to take the following steps:

1. download the data from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. unzipping the data 
3. merge the training and the test sets to create one data set.
4. extracts only the measurements on the mean and standard deviation for each measurement.
5. uses descriptive activity names to name the activities in the data set
6. appropriately labels the data set with descriptive variable names.
7. take the **mean** of the variables for each **Subject-Activity pair**


###Cleaning of the data

1. The data was split into train data and test data, so the first step was to load the data using read.table(). The Subject IDs and the activity labels were all in different files so they needed to be merged together using the cbind() function. Then we needed to merge the train data with the test data using the rbind() function. This gave us our full data set named **FullData**.
2. Next we needed to name all the columns in our **FullData** dataframe. First I named the first variable that corresponds to the subjects of the experiment, then I named the second variable that corresponds to the activity. Then I named the other vairables using the **features.txt** file. 
3. Next I extracted the variables corresponding to the mean and standard deviation measurements by using the grep() function. The dataframe that is left is called **MeanStdData**
4. Now we need to give the columns proper descriptive names, this was done by using the sub() function
5. Afterwards I turned the data in the Activity column into a factor variable representing the activities WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. This was done by using the **activity_labels.txt** file
6. The last step is to group the variables according to **Subject** and **Activity**. This was done by using the group_by() function from the dplyr package. Next I used summarize_all(mean) to get the mean for all of the **Subject-Activity** pairs.This dataframe is called **TidyData** as it satisfies all the conditions for a tidy data set.



##Description of the variables in the tidy_data.txt file
```{r summary tidy data}
TidyDataSet <- read.table("./TidyData.txt", header = TRUE)
str(TidyDataSet)
```



### Note on variables 
The most important variables in this dataset are **Subject** and **Activity**, while the rest of the variables are measurements taken by the gyroscope and the accelerometer of the Samsung Galaxy S2.

**Subject** is a variable where each number corresponds to the number of one of the 30 subjects observations were taken from.

**Activity** is a variable that has 6 levels : WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING


```{r}
str(TidyDataSet$Subject)
str(TidyDataSet$Activity)

```


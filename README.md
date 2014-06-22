Getting and Cleaning Data Project README
========================================================

## This project is part of the Coursera course on Getting and Cleaning data offered through John Hopkins ##

The aim of this project is to demonstrate the ability to read, clean and summarize a given data set into a tidy data set that can be used for further procesing.

The data set provided contains data obtained from sensors on a Samsung smart phone. The data contains measurements from the phone's accelerometer and gyroscope taken as 30 subjects performed 6 activities - walking, walking upwards, walking downwards, sitting, standing and laying down.

Details about the experiement can be found at the UCI Machine Learning Repository's website: [
Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The required script, run_analysis.R is written as a function that performs all the necessary processing steps. The code can be run as follows:

'<source("run_analysis.R")
run_analysis()>'

The script runs from the working directory. The [Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is downloaded and extracted into a Data folder within the working directory. If a Data folder does not exist, a new one is created. 

Please refer to the CodeBook provided for details regarding transformations and processes implemented to clean, subset and summarize the data as required as well as a list of variables in the final data set.

The final tidy, summarized data set is output as a space delimited .txt file, called *tidyData.txt* generated using the '<write.table>' command. It can be read back into R from the working directory using:

'<read.table(file="tidyData.txt", sep=" ", header=TRUE)>'
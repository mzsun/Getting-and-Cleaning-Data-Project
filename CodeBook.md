Getting and Cleaning Data Project CodeBook
========================================================

This project is part of the Coursera course on **Getting and Cleaning Data** offered through John Hopkins

The aim of this project is to demonstrate the ability to read, clean and summarize a given data set into a tidy data set that can be used for further procesing.

The data set provided contains data obtained from sensors on a Samsung smart phone. The data contains measurements from the phone's accelerometer and gyroscope taken as 30 subjects performed 6 activities - walking, walking upwards, walking downwards, sitting, standing and laying down.

Details about the experiement can be found at the UCI Machine Learning Repository's website: [
Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The required script, run_analysis.R is written as a function that performs all the necessary processing steps. The code can be run as follows:

```{r}
source("run_analysis.R")```
```{r}
run_analysis()```

####Part 1 

Data is downloaded and extracted into a Data folder within the working directory. The files are loaded, analyzed and modified as follows.

The variable and activity label names are loaded into R from the *activity_labels.txt* and the *features.txt* files provided in the data set. These are stored as the variables *ActivityLabels* and *FeaturesList* respectively. Column headings are added to this data.

Next the script extracts the test data set and the activity and subject data associated with this data set. These are stored in as the variables *TestSet*, *TestActivityLabels* and *TestSubject*. The activity and subject data is added to the test data set.

The script then extracts the training data set and the activity and subject data associated with this data set. These are stored in as the variables *TrainSet*, *TrainActivityLabels* and *TrainSubject*. The activity and subject data is added to the training data set.

Once the two sets are complete, they are combined together by rows to create one data set containing data for all the 30 subjects involved in the experiment.

#### Part 2
The aim is to extract those variables that measure the mean and standard deviation for each of the sensor measurement taken.
Based on the information provided in the *features_info.txt* file, provided with the data set, the measurements with names containing "mean()" and "std()" were extracted.

Before applying the list of variable names to the data set, labels for the subject and activity data, that was appended to the tests and training data before merging, are added to the list of variables loaded into R - *FeaturesList*. The variable list is now searched for variable names containing the mean and standard deviation measurements. This information is used to index and subset the data frame for the desired columns, including the subject and activity data. 

The resulting data set *SubsetDataSet* gives a list of 66 desired measurements. The subset data contains 68 columns; 66 measurements, 1 column indicating the subject performing the activity and 1 column indicating the activity that was being performed.

#### Part 3
This part focuses on the activity data/column of our data set (*SubsetDataSet$Activity*). Factor levels are created for the activity data and appropriate activity names are applied appropriately for the 6 activity levels.

#### Part 4
This part requires cleaning up the variable/feature names. A variable name format similar to the one used by the authors of the experiment was selected as these provided the necessary descriptive information regarding the measurements concisely.

As explained in the *features_info.txt* file, the list of measurements and their names are summarized below. Below is an explanation of the variable name format being used in this data set.

* **Acc** denotes meaurements obtained from the accelerometer.
* The measurements obtained from the accelerometer are broken down into body movement and gravitational components identified by **BodyAcc** and **GravityAcc** respectively
* **Gyro** denotes measurements obtained from the gyroscope
* **-XYZ** denotes the direction of the 3 axial measurements collected from the accelerometer and gyroscope.
* Time derivation for body acceleration and angular velocity was used to obtain **Jerk** measurements.
* The magnitude of all these 3 dimensional measurements were calculated and are reported under the labels ending with **Mag**
* An FFT was applied to the signals to obtain frequency domain measurements. The letters **t** and **f** within the measurement names indicate whether the measurement is a time domain or frequency domain measurement.
* Since the dataset extracted focuses on the mean and standard deviation estimates of these variables, the measurement names are preceeded with **MEAN** and **STD** to indicate whether the computed variable is the mean or standard deviation of the recorded measurement.
* Breaks within the variable names were provided using *"."* to make for easier reading of the variable names. This was used instead of *"-"* because R converts the *-* to *.* when reading in the header names.

Below is a final list of the 68 measurements/columns used in the tidy data set.

1. "Subject"                
2. "Activity"              
3. "MEAN-tBodyAcc-X"        
4. "MEAN-tBodyAcc-Y"       
5. "MEAN-tBodyAcc-Z"        
6. "STD-tBodyAcc-X"        
7. "STD-tBodyAcc-Y"         
8. "STD-tBodyAcc-Z"        
9. "MEAN-tGravityAcc-X"     
10. "MEAN-tGravityAcc-Y"    
11. "MEAN-tGravityAcc-Z"     
12. "STD-tGravityAcc-X"     
13. "STD-tGravityAcc-Y"      
14. "STD-tGravityAcc-Z"     
15. "MEAN-tBodyAccJerk-X"    
16. "MEAN-tBodyAccJerk-Y"   
17. "MEAN-tBodyAccJerk-Z"    
18. "STD-tBodyAccJerk-X"    
19. "STD-tBodyAccJerk-Y"   
20. "STD-tBodyAccJerk-Z"    
21. "MEAN-tBodyGyro-X"       
22. "MEAN-tBodyGyro-Y"      
23. "MEAN-tBodyGyro-Z"       
24. "STD-tBodyGyro-X"       
25. "STD-tBodyGyro-Y"        
26. "STD-tBodyGyro-Z"       
27. "MEAN-tBodyGyroJerk-X"   
28. "MEAN-tBodyGyroJerk-Y"  
29. "MEAN-tBodyGyroJerk-Z"   
30. "STD-tBodyGyroJerk-X"   
31. "STD-tBodyGyroJerk-Y"    
32. "STD-tBodyGyroJerk-Z"   
33. "MEAN-tBodyAcc-Mag"      
34. "STD-tBodyAcc-Mag"      
35. "MEAN-tGravityAcc-Mag"   
36. "STD-tGravityAcc-Mag"   
37. "MEAN-tBodyAccJerk-Mag"  
38. "STD-tBodyAccJerk-Mag"  
39. "MEAN-tBodyGyro-Mag"     
40. "STD-tBodyGyro-Mag"     
41. "MEAN-tBodyGyroJerk-Mag" 
42. "STD-tBodyGyroJerk-Mag" 
43. "MEAN-fBodyAcc-X"        
44. "MEAN-fBodyAcc-Y"       
45. "MEAN-fBodyAcc-Z"        
46. "STD-fBodyAcc-X"        
47. "STD-fBodyAcc-Y"         
48. "STD-fBodyAcc-Z"        
49. "MEAN-fBodyAccJerk-X"    
50. "MEAN-fBodyAccJerk-Y"   
51. "MEAN-fBodyAccJerk-Z"    
52. "STD-fBodyAccJerk-X"    
53. "STD-fBodyAccJerk-Y"     
54. "STD-fBodyAccJerk-Z"    
55. "MEAN-fBodyGyro-X"       
56. "MEAN-fBodyGyro-Y"      
57. "MEAN-fBodyGyro-Z"       
58. "STD-fBodyGyro-X"       
59. "STD-fBodyGyro-Y"        
60. "STD-fBodyGyro-Z"       
61. "MEAN-fBodyAcc-Mag"      
62. "STD-fBodyAcc-Mag"      
63. "MEAN-fBodyAccJerk-Mag"  
64. "STD-fBodyAccJerk-Mag"  
65. "MEAN-fBodyGyro-Mag"     
66. "STD-fBodyGyro-Mag"     
67. "MEAN-fBodyGyroJerk-Mag" 
68. "STD-fBodyGyroJerk-Mag"


#### Part 5
In order to produce a tidy data set containing the means of the variables extracted in the subset data set, by activity and subject, the data set was first melted by the activity being performed and the subject id. This data frame was then cast with the mean function to obtain a tidy data set *tidyData* containing the means of each variable by subject and activity.

The tidy data set has one row for each observation: A subject, the activity being performed by the subject and the average of the (subset of) measurements obtained for this subject performing the given activity. Since the experiement had 30 subjects performing 6 activities, we have 180 rows in our data set and 68 columns as identified in Part 3 above.

The tidy summarized data set is output as a space delimited .txt file, called *tidyData.txt* generated using the '<write.table>' command. It can be read back into R from the working directory using:

'<read.table(file="tidyData.txt", sep=" ", header=TRUE)>'

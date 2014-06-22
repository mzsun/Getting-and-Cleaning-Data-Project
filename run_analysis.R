run_analysis <- function(){
  
  ###### 1. Merges the training and the test sets to create one data set #####
  
  #Download and extract the data in a Data Directory
  #Extract the features and activity data that apply to both test
  #and training data sets
  #Extract the Test Data Set
  #Extract the Training Data Set
  #Merge the two Data sets
  
  if (!file.exists("./Data")){dir.create("./Data")}
  dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(dataURL, destfile="./Data/UCI-HAR-Dataset.zip")
  dateDownloaded <- date()
  unzip("./Data/UCI-HAR-Dataset.zip", exdir="./Data")
  
  ### LABELS ###
  
  #Read in activity labels
  ActivityLabels <- read.table(
    file="./Data/UCI HAR Dataset/activity_labels.txt", sep="", 
    header=FALSE, colClasses="character")
  names(ActivityLabels) <- c("ActivityClass", "ActivityName")
  ActivityLabels$ActivityClass <- as.numeric(ActivityLabels$ActivityClass)
  
  # Read in features list/variable names
  FeaturesList <- read.table(file="./Data/UCI HAR Dataset/features.txt", 
                             sep="", header=FALSE, colClasses="character")
  names(FeaturesList) <- c("FeatureNumber", "FeatureName")
  FeaturesList$FeatureNumber <- as.numeric(FeaturesList$FeatureNumber)
  
  ### TEST DATA SET ###
  
  #Test Labels Data - Identifies 1 of 6 activities being performed 
  #by the subject
  TestActivityLabels <- read.table("./Data/UCI HAR Dataset/test/y_test.txt",
                                   sep="", header=FALSE)
  
  #Test Subject Data - Each row identifies the subject who 
  #performed the activity for each window sample
  TestSubject <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt", 
                            sep="", header=FALSE)
  
  #Test Data Set
  TestSet <- read.table("./Data/UCI HAR Dataset/test/X_test.txt", 
                        sep="", header=FALSE)
  
  # Add the subject and activity data to the test data set
  TestSet <- cbind(TestSubject, TestActivityLabels, TestSet)
  
  ### TRAINING DATA SET ###
  
  #Train Labels Data - Identifies 1 of 6 activities being performed 
  #by the subject
  TrainActivityLabels <- read.table("./Data/UCI HAR Dataset/train/y_train.txt",
                                    sep="", header=FALSE)
  
  #Train Subject Data - Each row identifies the subject who 
  #performed the activity for each window sample
  TrainSubject <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt", 
                             sep="", header=FALSE)
  
  #Training Data set
  TrainSet <- read.table("./Data/UCI HAR Dataset/train/X_train.txt", 
                         sep="", header=FALSE)
  
  # Add the subject and activity data to the training data set
  TrainSet <- cbind(TrainSubject, TrainActivityLabels, TrainSet)
  
  
  #### MERGING THE TWO DATA SETS ###
  DataSet <- rbind(TestSet, TrainSet)
  
  
  ##### 2. Extracts only the measurements on the mean and standard 
  # deviation for each measurement ########
  #Use the features data to label the data set 
  #(add the "Subject" and "Activity" Labels to the features data)
  #extract the measurements on mean and standard deviabion
  
  #Add Subject and Activity column names to the Features List
  FeaturesList <- rbind(c(1,"Subject"), c(2, "Activity"),  FeaturesList)
  
  #Use Features List to label the data set
  names(DataSet) <- FeaturesList$FeatureName
  
  #Identify index for features with mean and Standard Deviation
  MeanSearch <- 
    grep("mean()", 
         names(DataSet), ignore.case=TRUE, fixed=TRUE, value=FALSE)
  StdSearch <- grep("std()", names(DataSet), ignore.case=TRUE, fixed=TRUE, value=FALSE)
  
  #Create an index into the dataframe for features containing mean and std
  #Add indexes for Subject and Activity
  MeanStdIndex <- sort(c(1, 2, MeanSearch, StdSearch))
  
  SubsetDataSet <- DataSet[ ,MeanStdIndex]
  
  
  
  ##### 3. Uses descriptive activity names to name the 
  #activities in the data set #########
  #Use ActivityLabels to give the activites a descriptive name
  SubsetDataSet$Activity <- factor(SubsetDataSet$Activity, 
                                   levels=c(1,2,3,4,5,6), labels=ActivityLabels$ActivityName)
  
  
  
  ##### 4. Appropriately labels the data set with descriptive 
  # variable names. ############
  
  names(SubsetDataSet)
  #Remove (, ) from variable names
  #Start variable names with mean or std
  VarNames <- names(SubsetDataSet)
  
  mysub <- function(x, mypattern, myreplacement) {
    if(grepl(pattern=mypattern, x, ignore.case=TRUE))
    {x <- paste0(myreplacement, gsub(pattern=mypattern, replacement="", x))}
    else {x <- x}
  }
  
  VarNames1 <- sapply(VarNames, gsub, pattern="\\(\\)", replacement="", simplify=TRUE)
  VarNames2 <- sapply(VarNames1, mysub, mypattern="mean", myreplacement="MEAN-")
  VarNames3 <- sapply(VarNames2, mysub, mypattern="std", myreplacement="STD-")
  VarNames4 <- sapply(VarNames3, gsub, pattern="\\--", replacement="-", simplify=TRUE)
  VarNames5 <- sapply(VarNames4, gsub, pattern="Mag-", replacement="-Mag", simplify=TRUE)
  VarNames6 <- sapply(VarNames5, gsub, pattern="BodyBody", replacement="Body", simplify=TRUE)
  varNames7 <- sapply(varNames6, gsub, pattern="\\-", replacement="\\.", simplify=TRUE)
  names(VarNames7) <- NULL
  
  names(SubsetDataSet) <- VarNames7
  #head(SubsetDataSet)
  
  
  
  ##### 5. Creates a second, independent tidy data set with the 
  # average of each variable for each activity and each subject #######
  
  library("reshape2")
  moltenData <- melt(SubsetDataSet, id.vars=c("Activity", "Subject"))
  tidyData <- dcast(moltenData, Subject+Activity~variable, fun=mean)
  
  #tidyData2 <- aggregate(.~Subject+Activity, FUN=mean, data=SubsetDataSet)
  
  #Create output text file
  write.table(tidyData, file="tidyData.txt", sep=" ", row.names=FALSE)
}
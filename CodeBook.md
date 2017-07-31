# CodeBook
JULIA F  
31 juillet 2017  



# Human Activity Recognition Using Smartphones Tidy Data Set 

## Introduction

This CodeBook is associated with "Data cleaning" course and is a part of the project.

The resulting tidy dataset "tidy_dataset.txt" is the object of this CodeBook.

It describes the variables, the data, and any transformations or work that were performed to clean up the data.

## Source

The original experiment from university of Geneva is accessible at : <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The raw dataset is in a zip file at : <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Format

A data frame with 180 observations on 69 variables.

> Variables :  
 [1] "id_subject"                 Id of the subject  
 [2] "id_activity"                Id of the activity  
 [3] "activity_label"             Label of the activity  
 
 On the next attributes, there is mean() and std() values on the three axis (X, Y and Z) for these signals :
 
* tBodyAcc
* tGravityAcc
* tBodyAccJerk
* tBodyGyro
* tBodyGyroJerk
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc
* fBodyAccJerk
* fBodyGyro
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
 
> Example :  
 [4] "tBodyAcc-mean()-X"          
 [5] "tBodyAcc-mean()-Y"          
 [6] "tBodyAcc-mean()-Z"          
 [7] "tBodyAcc-std()-X"           
 [8] "tBodyAcc-std()-Y"           
 [9] "tBodyAcc-std()-Z"           

## Data's description

The tidy dataset is a subset of the original data. The following transformations have been applied :

* Training and testing sets were merged
* All means and standard deviations were selected for each measurement
* Descriptive activity names has been added
* Appropriately labels with descriptive variable names has been set to attributes
* This tidy dataset with average of each variable for each activity and each subject

## Transformations

This section describes the transformations applied to original data set to pruduct this tidy data set

### libraries

```r
library("dplyr")
```

### Unzip the file


```r
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
```

### Get raw data for training sets, and set appropriated names on columns


```r
# Read data sets in the TXT files
subjectTrain <- read.table(file.path("./UCI HAR Dataset/train/subject_train.txt"), header = FALSE)
names(subjectTrain) <- c("id_subject")

yTrain <- read.table(file.path("./UCI HAR Dataset/train/y_train.txt"), header = FALSE)
names(yTrain) <- c("id_activity")

# By default, read.table separate columns by ‘white space’, that is one or more spaces, tabs, newlines or carriage returns
xTrain <- read.table(file.path("./UCI HAR Dataset/train/x_train.txt"), header = FALSE)

# xTrain's attributes are stocked in the file "features.txt"
xAttributes <- read.table(file.path("./UCI HAR Dataset/features.txt"), header = FALSE)
names(xAttributes) <- c("index_attribute", "label_attribute")

# Set these attributes to xTrain's names
names(xTrain) <- xAttributes$label_attribute
```

### Identically, get raw data for testing sets, and set appropriated names on columns


```r
# Read data sets in the TXT files
subjectTest <- read.table(file.path("./UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
names(subjectTest) <- c("id_subject")

yTest <- read.table(file.path("./UCI HAR Dataset/test/y_test.txt"), header = FALSE)
names(yTest) <- c("id_activity")

# By default, read.table separate columns by ‘white space’, that is one or more spaces, tabs, newlines or carriage returns
xTest <- read.table(file.path("./UCI HAR Dataset/test/x_test.txt"), header = FALSE)

# Set its attributes to xTest's names
names(xTest) <- xAttributes$label_attribute
```

### 1. Merging training and testing datasets


```r
# First, merging of the three files of each dataset
trainSet <- cbind(subjectTrain, yTrain, xTrain)
testSet  <- cbind(subjectTest,  yTest,  xTest)

# Second, merging of the two sets
dataset  <- rbind(trainSet, testSet)
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement


```r
# "grep" command allow to select attributes which names contains "mean()" or "std()"
# Attributes "id_subject" and "id_activity" are kept
dataset <- dataset[,c(1:2, grep("mean\\(|std\\(", xAttributes$label_attribute)+2)]
```

### 3. Uses descriptive activity names to name the activities in the data set


```r
# Activities' labels are stocked in the file "activity_labels.txt"
activitiesLabels <- read.table(file.path("./UCI HAR Dataset/activity_labels.txt"), header = FALSE)
names(activitiesLabels) <- c("id_activity", "activity_label")

# Join between dataset and activitiesLabels on "id_activity"
dataset <- dataset %>%
   left_join(activitiesLabels, by = "id_activity") %>%
   select("id_subject", "id_activity", "activity_label", everything())
```

### 4. Appropriately labels the data set with descriptive variable names


```r
# Appropriated labels have already been applied previously when pre-processing xTrain and xTest
names(dataset)
```

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


```r
# A group_by can meaned all variable in a single pass
tidyDataset <- dataset %>%
   group_by(id_subject, id_activity, activity_label) %>%
   summarise_all(mean)

# Write this tidy dataset in a file
write.table(tidyDataset, "tidy_dataset.txt", row.name=FALSE)
```


## Usage


```r
tidyDataset <- read.table("tidy_dataset.txt")
head(tidyDataset)
```


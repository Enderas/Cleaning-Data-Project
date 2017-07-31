## This codebook contains all codes necessary to clean provided data
## Assignment for Week 4 of "Cleaning Data" course

## libraries
library("dplyr")

## Unzip the file

unzip("getdata_projectfiles_UCI HAR Dataset.zip")


## Get raw data for training sets, and set appropriated names on columns

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



## Identically, get raw data for testing sets, and set appropriated names on columns

subjectTest <- read.table(file.path("./UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
names(subjectTest) <- c("id_subject")

yTest <- read.table(file.path("./UCI HAR Dataset/test/y_test.txt"), header = FALSE)
names(yTest) <- c("id_activity")

# By default, read.table separate columns by ‘white space’, that is one or more spaces, tabs, newlines or carriage returns
xTest <- read.table(file.path("./UCI HAR Dataset/test/x_test.txt"), header = FALSE)

# Set its attributes to xTest's names
names(xTest) <- xAttributes$label_attribute



## 1. Merging training and testing datasets

# First, merging of the three files of each dataset
trainSet <- cbind(subjectTrain, yTrain, xTrain)
testSet  <- cbind(subjectTest,  yTest,  xTest)

# Second, merging of the two sets
dataset  <- rbind(trainSet, testSet)



## 2. Extracts only the measurements on the mean and standard deviation for each measurement

# "grep" command allow to select attributes which names contains "mean()" or "std()"
# Attributes "id_subject" and "id_activity" are kept
dataset <- dataset[,c(1:2, grep("mean\\(|std\\(", xAttributes$label_attribute)+2)]



## 3. Uses descriptive activity names to name the activities in the data set

# Activities' labels are stocked in the file "activity_labels.txt"
activitiesLabels <- read.table(file.path("./UCI HAR Dataset/activity_labels.txt"), header = FALSE)
names(activitiesLabels) <- c("id_activity", "activity_label")

# Join between dataset and activitiesLabels on "id_activity"
dataset <- dataset %>%
   left_join(activitiesLabels, by = "id_activity") %>%
   select("id_subject", "id_activity", "activity_label", everything())



## 4. Appropriately labels the data set with descriptive variable names

# Appropriated labels have already been applied previously when pre-processing xTrain and xTest
names(dataset)



## 5. From the data set in step 4, creates a second, independent tidy data set with the average
## of each variable for each activity and each subject

# A group_by can meaned all variable in a single pass
tidyDataset <- dataset %>%
   group_by(id_subject, id_activity, activity_label) %>%
   summarise_all(mean)

# Write this tidy dataset in a file
write.table(tidyDataset, "tidy_dataset.txt")

# Can be read with :
# tidyDataset <- read.table("tidy_dataset.txt")
# head(tidyDataset)

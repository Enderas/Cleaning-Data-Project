# Readme
JULIA F  
31 juillet 2017  



# Readme for "Human Activity Recognition Using Smartphones Tidy Data Set"

## Introduction

This readme is associated with "Data cleaning" course and is a part of the project.

It describes the different scripts and how they are connected.

## Source

The original experiment from university of Geneva is accessible at : <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The raw dataset is in a zip file at : <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Content and usage

### tidy_dataset.txt

This tidy dataset is a subset of the original data. The following transformations have been applied :

* Training and testing sets were merged
* All means and standard deviations were selected for each measurement
* Descriptive activity names has been added
* Appropriately labels with descriptive variable names has been set to attributes
* This tidy dataset with average of each variable for each activity and each subject

### CodeBook.Rmd

This code book describes the variables, the data, and any transformations or work that were performed to clean up the original data.

### run_analysis.R

This script performs the analysis described in the "tidy_dataset.txt" paragraph.

It contains all the code necessary to rebuild th etidy data set from the original data set.


#Getting and Cleaning Data Week 4 Course Project
---
title: "READ_ME"
author: "AdeBaddest"
date: "9th December 2019"

##Usage
This script was created to clean and summarise the data set found at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The only pre-requirements are for you to download the above ZIP file and change the working directory at the top of the analysis script to the directory in which the file has been downloaded too. 

##Function
This run analysis script will:

* Read the required data into R
* Combine the test and training datasets into one combined dataset
* Extract mean and std columns
* Correctly label activity codes
* Summarise the data to create a new file with the means of each activity and subject
* write the output of this to a clean txt file named secTidySet.txt

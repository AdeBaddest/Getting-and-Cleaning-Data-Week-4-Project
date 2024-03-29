##Downloading and Cleaning the Data

rm(list = ls(all.names = TRUE))

setwd("C:/Users/Admin/Documents/R/win-library/3.6")

# Unzip dataSet to /3.6/UCI HAR Dataset
unzip(zipfile ="C:/Users/Admin/Documents/R/win-library/3.6/getdata_projectfiles_UCI_HAR_Dataset.zip", exdir ="C:/Users/Admin/Documents/R/win-library/3.6")

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
# lets check the zip file and the new folder that has been unzipped

list.files("C:/Users/Admin/Documents/R/win-library/3.6") 

#define the path where the new folder has been unzipped
{
pathdata = file.path("C:/Users/Admin/Documents/R/win-library/3.6", "UCI HAR Dataset") }

#create a file which has the 28 file names
files = list.files(pathdata, recursive=TRUE)

##Making the Test and Training Dataset

### 1. Output Steps - Here we begin how to create the data set of training and test
#Reading training tables - xtrain / ytrain, subject train
{
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
}
#Reading the testing tables
{
xtest = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
}
#Read the features data
{
features = read.table(file.path(pathdata, "features.txt"),header = FALSE) }

#Read activity labels data
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)

##Tagging the Test and Training Datasets

#Create Sanity and Column Values to the Train Data
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"

#Create Sanity and column values to the test data
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"

#Create sanity check for the activity labels value
colnames(activityLabels) <- c('activityId','activityType')

#Merging the train and test data - important outcome of the project
mrg_train = cbind(ytrain, subject_train, xtrain)
mrg_test = cbind(ytest, subject_test, xtest)

#Create the main data table merging both table tables - this is the outcome of 1
setAllInOne = rbind(mrg_train, mrg_test)

##2Extracting only the measurements of the mean ans Standard deviation for each of the objects 

# Need step is to read all the values that are available
colNames = colnames(setAllInOne)

#Need to get a subset of all the mean and standards and the correspondongin activityID and subjectID 
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

#A subtset has to be created to get the required dataset
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

##Use descriptive activity to name the activities in the datasets 
setWithActivityNames = merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
##New tidy set has to be created 
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

##Saving the new data
#The last step is to write the ouput to a text file 
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
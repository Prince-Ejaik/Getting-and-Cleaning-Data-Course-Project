# # Peer Graded Assignment: Getting and Cleaning Data Course Project

# Preliminary Stage:

# Installing and Loading required package(s)
install.packages(“dplyr”) 
library(dplyr)

# Download the dataset
# GaCD stands for Getting and Cleaning Data
filename <- "GaCD_Project.zip"

# Check if file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Furthermore, check if the corresponding folder already exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Appropriating training and test data tables accordingly

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# run_Analysis R Script
# Creating an R script called run_analysis.R that factors in the following steps:

# Step 1 merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merge_Data <- cbind(Subject, Y, X)

# Step 2 extracts only the measurements on the mean and standard deviation for each measurement.

Tidy_Dataset <- Merge_Data %>% select(subject, code, contains("mean"), contains("std"))

# Step 3 uses descriptive activity names to name the activities in the data set.

Tidy_Dataset$code <- activities[Tidy_Dataset$code, 2]

# Step 4 appropriately labels the dataset with descriptive variable names.

names(Tidy_Dataset)[2] = "activity"
names(Tidy_Dataset)<-gsub("Acc", "Accelerometer", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("Gyro", "Gyroscope", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("BodyBody", "Body", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("Mag", "Magnitude", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("^t", "Time", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("^f", "Frequency", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("tBody", "TimeBody", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("-mean()", "Mean", names(Tidy_Dataset), ignore.case = TRUE)
names(Tidy_Dataset)<-gsub("-std()", "STD", names(Tidy_Dataset), ignore.case = TRUE)
names(Tidy_Dataset)<-gsub("-freq()", "Frequency", names(Tidy_Dataset), ignore.case = TRUE)
names(Tidy_Dataset)<-gsub("angle", "Angle", names(Tidy_Dataset))
names(Tidy_Dataset)<-gsub("gravity", "Gravity", names(Tidy_Dataset))

# Finally, step 5 creates a second, independent tidy dataset with the average of each variable for each activity and each subject from the data set in step 4.

Indepedendet_Dataset <- Tidy_Dataset %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(Indepedendet_Dataset, "Indepedendet_Dataset.txt", row.name=FALSE)

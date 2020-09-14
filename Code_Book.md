The run_analysis.R script first of all prepares the dataset and then carries out the following steps as outlined in the project instructions.
Step 1 is about downloading the required dataset
o	Dataset successfully downloaded and extracted from the following folder UCI HAR Dataset

Step 2 is about key variables and linking them up with the dataset
o	features <- features.txt : 561 observations (rows) and 2 variables (columns)
The features selected for this database are taken from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
o	activities <- activity_labels.txt : 6 observations and 2 variables
List of activities performed when the corresponding measurements were taken and its labels (identifications)
o	subject_test <- test/subject_test.txt : 2947 observations, 1 variable
contains test dataset of 9/30 volunteer test subjects under observation
o	x_test <- test/X_test.txt : 2947 observations, 561 variables
contains recorded features test data
o	y_test <- test/y_test.txt : 2947 observations, 1 variable
contains test data of activities’ labels
o	subject_train <- test/subject_train.txt : 7352 observations, 1 variable
contains train data of 21/30 volunteer subjects under observation
o	x_train <- test/X_train.txt : 7352 observations, 561 variables
contains recorded features train data
o	y_train <- test/y_train.txt : 7352 observations, 1 variable
contains train data of activities’ labels

Step 3 involves the merging of the training and the test dataset to create a new dataset
o	X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
o	Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
o	Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
o	Merge_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

Step 4 considers only the extraction of the measurements on the mean and standard deviation for each measurement
o	Tidy_Dataset (10299 rows, 88 columns) is created by subsetting Merge_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Step 5 is about using descriptive activity names to name the activities in the dataset
o	Entire numbers in code column of the Tidy_Dataset replaced with corresponding activity taken from second column of the activities variable

Step 6 involves the labeling of the dataset with descriptive variable names accordingly
o	code column in Tidy_Dataset renamed into activities
o	Acc in column’s name replaced by Accelerometer
o	Gyro in column’s name replaced by Gyroscope
o	BodyBody in column’s name replaced by Body
o	Mag in column’s name replaced by Magnitude
o	f in column’s name replaced by Frequency
o	t in column’s name replaced by Time

Final step is about the realization of a second, independent tidy data set with the average of each variable for each activity and each subject from the dataset in step 4
o	Indepedendet_Dataset (180 rows, 88 columns) is created by sumarizing Tidy_Dataset taking the means of each variable for each activity and each subject, after groupped by subject and activity.
o	Export Indepedendet_Dataset into Indepedendet_Dataset.txt file.


# Introdution
The dataset, found in "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" contains information of a group of 30 volunteers.

The dataset is divided into 6 smaller pieces: x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt. All the files can be found within the link above.

The features.txt contains the correct variables names. The activity_labels.txt contains the desciptive names for each activity label.

The run_analysis.R is the code used for the data preparation. 

In the lines below, I will explain the steps done to achieve the following five objectives, specified for the project:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 1. Download the data
First at all, I downloaded the file and extracted in this path: "D:\\Documentos\\R\\Coursera\\getting_cleaning\\UCI HAR Dataset"

#2. Read the libraries that will be used in the code
With the function library(), read the packages 'data.table' and 'dplyr'.

#3. Read all data and set to a variable
The first code is responsible to read all the data on the "UCI HAR Datased" folder: x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt, features.txt and activity_labels.txt; and assign to specifics variables.
features <- features.txt
activity <- activity_labels.txt
subject_test <- subject_test.txt
x_test <- X_test.txt
y_test <- y_test.txt
subject_train <- subject_train.txt
x_train <- X_train.txt
y_train <- Y_train.txt

#4. Merge the datasets into ONE dataset
Initially, create two data.frames, "x" and "y". "x" contains x_train and x_test, and "y" contains y_train and y_test. Use the rbind function.
Next, create the "subject" data.frame. This data.frame contains subject_train and subject_test. Use the rbind function.
Last, merge all datasets into one using the function cbind. Call it "dataset"

#5. Extract only the measurements on the mean and STD for each measurement
First use the function colnames for the main dataset.
It is possible to see that variables has some statistics calculated as 'mean', 'kurtosis', 'entropy', 'max', and others.
We only want mean and standard deviation columns.

Using the select function, select the collumns that contains the word "subject", "code", "mean" and "std".
It is necessary to combine the functions select and contains, as the following: select(dataset, contains(c("subject", "code", "mean", "std")))

#6. Uses descriptive activity names to name the activities in the data set
Using the dataset "activity", join the datasets (inner_join) and reorganize the order of columns, replacing the numbers by the name of activities.

#7. Appropriately labels the data set with descriptive variable names.
Use the function gsub for substitute each word in the vector of names for the dataset:
Acc <- Accelerometer
Gyro <- Gyroscope
BodyBody <- Body
Mag <- Magnitude
start with character f <- Frequency
start with character t <- Time
tbody <- TimeBody
angle <- Angle
gravity <- Gravity

#8. Create a new dataset, with the average of each variable for each activity and each subject 
Using the group_by function, group the dataset for "subject" and "activity". Then, sumarise by mean.

#9. Export the new information to a txt file.
Use write.table.

The first two columns refers to each subject and activity made. The code column is equal to the activity column.
All other columns are the feature values (mean).

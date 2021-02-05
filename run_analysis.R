setwd("D:\\Documentos\\R\\Coursera\\getting_cleaning\\UCI HAR Dataset")
getwd()

library(data.table)
library(dplyr)

?read.table

#1. Merge datasets
#read all data and set to a variable (dataset)
features <- read.table("features.txt", col.names = c("n","functions"))
activity <- read.table("activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("test\\subject_test.txt", col.names = "subject")
x_test <- read.table("test\\X_test.txt", col.names = features$functions)
y_test <- read.table("test\\y_test.txt", col.names = "code")
subject_train <- read.table("train\\subject_train.txt", col.names = "subject")
x_train <- read.table("train\\X_train.txt", col.names = features$functions)
y_train <- read.table("train\\Y_train.txt", col.names = "code")

#merge each dataset 
x <- rbind(x_train, x_test) 
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
dataset <- cbind(subject, y, x)

#2. extract only the measurements on the mean and STD for each measurement
colnames(dataset)
#we can see that variables has some statistics calculated as 'mean', 'kurtosis', 'entropy', 'max', and others
#we only want mean and standard deviation

dataset1 <- select(dataset, contains(c("subject", "code", "mean", "std"))) 

#3. uses descriptive activity names to name the activities in the data set
dataset2 <- inner_join(dataset1, activity) #join datasets
dataset2 <- dataset2[,c(1,89,2, 3:88)] #reorganize the collumns

#4. Appropriately labels the data set with descriptive variable names.
#use gsub for substitute each word in the vector names(dataset2)
names(dataset2)<-gsub("Acc", "Accelerometer", names(dataset2))
names(dataset2)<-gsub("Gyro", "Gyroscope", names(dataset2))
names(dataset2)<-gsub("BodyBody", "Body", names(dataset2))
names(dataset2)<-gsub("Mag", "Magnitude", names(dataset2))
names(dataset2)<-gsub("^t", "Time", names(dataset2))
names(dataset2)<-gsub("^f", "Frequency", names(dataset2))
names(dataset2)<-gsub("tBody", "TimeBody", names(dataset2))
names(dataset2)<-gsub("-mean()", "Mean", names(dataset2), ignore.case = TRUE)
names(dataset2)<-gsub("-std()", "STD", names(dataset2), ignore.case = TRUE)
names(dataset2)<-gsub("-freq()", "Frequency", names(dataset2), ignore.case = TRUE)
names(dataset2)<-gsub("angle", "Angle", names(dataset2))
names(dataset2)<-gsub("gravity", "Gravity", names(dataset2))

#5. create a new dataset, with the average of each variable for each activity and each subject 
average <- dataset2 %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))

write.table(average, "average.txt", row.name=FALSE)



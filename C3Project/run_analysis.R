#Setting up necessary packages

library(dplyr)

#Reading files

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")

train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Merging the training and the test sets to create one data set.

df <- rbind(train, test)
labels <- rbind(train_labels,test_labels)
subjects <- rbind(train_subjects, test_subjects)

#Appropriately labeling the data set with descriptive variable names. 

colnames(df) <- features[,2]
colnames(df) <- gsub("\\()","",x=colnames(df))

#Extracting only the measurements on the mean and standard deviation for each measurement. 

df <- df[,grep("*mean*|*std*", features[,2])] 

#Using descriptive activity names to name the activities in the data set

activities <- inner_join(labels, activity_names)
df$subject <- subjects[,1]
df$activity <- activities[,2]
df <- select(df,subject, activity, 1:79)

#Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy <- df %>% group_by (subject, activity) %>% summarise_each(funs(mean))
write.table(tidy, file="tidy.txt", row.names=FALSE)

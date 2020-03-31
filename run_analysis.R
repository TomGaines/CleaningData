##merge the train and test data sets
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
Data <- cbind(subject, x, y)

## create a new data set with only the mean and standard deviation
Data <- Data %>% select(subject, code, contains("mean"), contains("std"))

## name the activities in the data set
Data$code <- activities[Data$code, 2]
names(Data)[2] = "activity"

##Add descriptive variable names
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data))
names(Data)<-gsub("-std()", "STD", names(Data))
names(Data)<-gsub("-freq()", "Frequency", names(Data))
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))

##Create a data set with the average of each variable for every subject and activity
Final_Table <- Data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(Final_Table, "Final Table.txt", row.name=FALSE)


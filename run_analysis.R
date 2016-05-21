library(plyr)
filename <- "dataset.zip"
## Download and unzip the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}



# Read data from files
features     <- read.table('UCI HAR Dataset/features.txt',header=FALSE) 
activityType <- read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE) 
subjectTrain <- read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE) 

#extract features which contains mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

xTrain       <- read.table('UCI HAR Dataset/train/X_train.txt',header=FALSE)[featuresWanted] 
yTrain       <- read.table('UCI HAR Dataset/train/y_train.txt',header=FALSE) 

# Read in the test data
subjectTest <- read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE)
xTest       <- read.table('UCI HAR Dataset/test/X_test.txt',header=FALSE)[featuresWanted]
yTest       <- read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE)


# Assigin column names to the data which is loaded
colnames(activityType)  <- c('activityId','activityType')
colnames(subjectTrain)  <- "subjectId"
colnames(xTrain)        <- featuresWanted.names
colnames(yTrain)        <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(xTest)       <- featuresWanted.names 
colnames(yTest)       <- "activityId"

#training data
trainingData <- cbind(yTrain,subjectTrain,xTrain)

#testing set
testData <- cbind(yTest,subjectTest,xTest)


#Merge data
finalData <- rbind(trainingData,testData)


# Create a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidyData    <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    <- merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')


# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
# first two columns (activity & subject)
averages_data <- ddply(finalData, .(subjectId, activityId), function(x) colMeans(x[, 3:81]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)

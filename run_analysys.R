library(dplyr)
library(httr)

## Check if the data directory exists and create if it doesn't
if(!file.exists("./data")) {
  dir.create("./data")
  ## Download and unzip dataset
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  tempFile <- tempfile()
  download.file(fileURL, tempFile)
  unzip(tempFile, exdir = "./data")
}



#read in the activity data sets, and produce tidy set containing the means of all MEAN and STD variables

#read in data sets from train directory
trainX_DF <-read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainY_DF <-read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainSub_DF <-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#read in data sets from test directory
testX_DF <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testY_DF <-read.table("./data/UCI HAR Dataset/test/y_test.txt")
testSub_DF <-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#read in feature descriptions and assign to column names
featureNames <-read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
activityNames <-read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
featureNames <- make.names(featureNames[,2],unique=T)
activityNames <-make.names(activityNames[,2],unique=T)
names(trainX_DF)<-featureNames
names(testX_DF)<-featureNames
names(trainSub_DF)<-c("SubjectID")
names(testSub_DF)<-c("SubjectID")
names(trainY_DF)<-c("Activity")
names(testY_DF)<-c("Activity")

#create DPLYR data tables
trainX_TBL <- tbl_df(trainX_DF)
trainY_TBL<-tbl_df(trainY_DF)
trainSub_TBL <-tbl_df(trainSub_DF)

testX_TBL <- tbl_df(testX_DF)
testY_TBL <-tbl_df(testY_DF)
testSub_TBL <-tbl_df(testSub_DF)

#build tidy train and test sets
testAll_TBL<-bind_cols(testSub_TBL,testY_TBL,testX_TBL)
trainAll_TBL <- bind_cols(trainSub_TBL,trainY_TBL,trainX_TBL)

#combine train and test
combinedData_TBL<-tbl_df(rbind(testAll_TBL,trainAll_TBL))

#convert Activity column to human readable text
temp <- mutate(combinedData_TBL,activityText=activityNames[Activity])
combinedData_TBL <- select(temp,1,564,3:563)
names(combinedData_TBL)[2]="Activity"

#subset the data to exract only participant, activity, and all mean and standard deviation variables

subsetData_TBL <- select(combinedData_TBL,1,2,contains("mean"),contains("std"))

summaryData <- group_by(subsetData_TBL,SubjectID,Activity) %>%
  summarise_each(funs(mean),3:88) %>%
  ungroup

summaryLabels <-names(summaryData)
summaryLabels2 <-paste(summaryLabels,"computedMeanOfSpecificSubject_ActivityPair",sep=".")
summaryLabels2[1]<-"SubjectID"
summaryLabels2[2]<-"Activity"

#expand some of the shorthand for the variable names to make it easier to read
summaryLabels3 <- sub("^t","timeDomainSignal.",summaryLabels2)
summaryLabels3 <- sub("^f","frequencyDomainSignal.",summaryLabels3)
summaryLabels3 <- sub("Acc",".asMeasuredByAccelerometer.",summaryLabels3)
summaryLabels3 <- sub("Gyro",".asMeasuredByGyroscope.",summaryLabels3)
summaryLabels3 <- sub("tBody","timeDomainSignal.Body",summaryLabels3)

names(summaryData)<-summaryLabels3
#order the columns so that all the time domain, frequency domain, and angular momentum variable columns are sequential
leftSplit <- select (summaryData,1:2)
rightSplit <- select (summaryData,3:88)
rightOrdered <- rightSplit[,order(names(rightSplit))]
columnOrderedSummary <- cbind(leftSplit,rightOrdered)

#fix up the angle variable names which were not so intuitive
names(columnOrderedSummary)[3] ="angleBetween.timeDomianSignal.MeanOfBodyAccelerometerVectorJerk.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[4] ="angleBetween.timeDomianSignal.MeanOfBodyAccelerometerVector.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[5] ="angleBetween.timeDomianSignal.MeanOfBodyGyroVectorJerk.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[6] ="angleBetween.timeDomianSignal.MeanOfBodyGyroVector.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[7] ="angleBetween.X.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[8] ="angleBetween.Y.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"
names(columnOrderedSummary)[9] ="angleBetween.Z.and.Gravity..computerMeanOfSpecificSubject_ActivityPair"

#output data to tidtData csv file

write.table(columnOrderedSummary, "tidydata.txt", row.names = FALSE)

#cleanup the workspace to eliminate extraneous data objects
rm(leftSplit)
rm(rightOrdered)
rm(rightSplit)
rm(temp)
rm(testAll_TBL)
rm(testSub_DF)
rm(testSub_TBL)
rm(testX_DF)
rm(testX_TBL)
rm(testY_DF)
rm(testY_TBL)
rm (subsetData_TBL)
rm(trainAll_TBL)
rm(trainSub_DF)
rm(trainSub_TBL)
rm(trainX_DF)
rm(trainX_TBL)
rm(trainY_DF)
rm(trainY_TBL)
rm(activityNames)
rm(featureNames)
rm(summaryLabels)
rm(summaryLabels2)
rm(summaryLabels3)

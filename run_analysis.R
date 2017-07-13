library(reshape2)
library(dplyr)

# home dir
# setwd("~/R/conclusaoCleanData/UCI HAR Dataset")

#### General data load ####
# activity labels
actLabels <- read.delim("activity_labels.txt", header = FALSE, sep = " ")

# features
featLabels <- read.delim("features.txt", header = FALSE, sep = " ")

#### Train data Load ####
# train labels
trainLabels <- read.delim("train/y_train.txt", header = FALSE, sep = " ")

# train subjects
trainSubjects <- read.delim("train/subject_train.txt", header = FALSE, sep = " ")
names(trainSubjects) <- "Subject"

# train data
colSize <- c(1, seq.int(16,16, length.out = nrow(featLabels)))
#trainData <- read.fwf("train/x_train.txt", widths = colSize, header = FALSE, n=100)
trainData <- read.fwf("train/x_train.txt", widths = colSize, header = FALSE)
trainData <- trainData[, 2:ncol(trainData)]
names(trainData) <- featLabels[,2]

#### Test data Load ####
# test labels
testLabels <- read.delim("test/y_test.txt", header = FALSE, sep = " ")

# test subjects
testSubjects <- read.delim("test/subject_test.txt", header = FALSE, sep = " ")
names(testSubjects) <- "Subject"

# test data
#testData <- read.fwf("test/x_test.txt", widths = colSize, header = FALSE, n=100)
testData <- read.fwf("test/x_test.txt", widths = colSize, header = FALSE)
testData <- testData[, 2:ncol(testData)]
names(testData) <- featLabels[,2]

#### Tidying data ####
# determine the name of each activity and add to the data
trainLabels <- inner_join(trainLabels, actLabels)
testLabels  <- inner_join(testLabels,  actLabels)
trainData2 <- cbind(trainLabels[, 2], trainData)
testData2  <- cbind(testLabels [, 2], testData)
names(trainData2)[1] <- "ActivityLabel"
names(testData2)[1] <- "ActivityLabel"

# add subject to the data
trainData2 <- cbind(trainSubjects, trainData2)
testData2 <- cbind(testSubjects, testData2)

# add the datasets on a single one
completeData <- rbind(trainData2, testData2)

#### MainData is the tidy data set ####
# select only the variables with mean and std and the two first columns with activity and subject
validNames <- grepl("mean", names(completeData)) | grepl("std", names(completeData))
validNames[1] <- TRUE
validNames[2] <- TRUE
mainData <- completeData[,validNames]

### Calculate mean ####
melted <- melt(mainData, c("Subject", "ActivityLabel"))
meanData <- dcast(melted, Subject + ActivityLabel ~ variable, mean)

### save the tidy data ###
write.csv(mainData, "tidyData.csv", row.names = FALSE)
write.csv(meanData, "meanData.csv", row.names = FALSE)

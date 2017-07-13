# Getting and Cleaning Data Course Project
This repository has the files for the final project of the "Cleaning data course" at Coursera.

The file "run_analysis.R" has the R code used to tidy the dataset from the smartphones accelerometers provided here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script joins the test and train data, add the subject and activity names to the dataset creating a tidy dataset saved as "tidyData.txt". It also evaluates the average of the features for each pair of subject / activity and saves this dataset on a file "meanData.txt".

The file "codeBook.md" describes the data on "tidyData.csv" and "meanData.csv".



# Getting-and-Cleaning-Data-Course-Project
This is course project for 'Getting and Cleaning Data' course by Johns Hopkins University which is available on coursera.
##Input Data Set
Full description abot input data set is available at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Input data set can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
##Description
R script `run_analysis.R` downloads the input data set from the source mentioned above.
`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.
`run_analysis.R` contains all the code to perform the analyses described in the 7 steps. 

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Load both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Load the activity and subject data for each dataset, and merges those columns with the dataset
5. Merge the two datasets
6. Convert the activity and subject columns into factors
7. Create a tidy dataset `tidy_data.txt` that consists of the average (mean) value of each variable for each subject and activity pair.




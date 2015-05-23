# datasciencecoursera : README for course 3 project work : run_analysis.R script.

-Source of data
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

-Project data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Prepare a consolidated dataset

- Read the training,test and features data
- Merge the training and test datasets
- The data fils for this activity are X_train and X_test

## Fetch the column names and retain only the mean and sd variable names

- Get all column names and apply to the dataset
- Retain only the mean and standard deviation columns in the dataset
- The data for this is available in features.txt

## Prepare the subject and activity variables

- 1. Prepare activity variable values for training and test datasets
- 2. Prepare subject variable values for training and test datasets
- 3. Prepare column labels for subject and activity
- 4. Prepare the datset with the subjects and activities data
- 5. rename the activity column to activity.name
- 6. Update the dataset with descriptive names for acivity based on lookup file
- 7. The data for this step is avaible in y_test.txt and y_train.txt
 
## Consolidation of variables,subject,activty in a data frame

- Join the actual dataset with descriptive labels dataset

## Transfer the data to a table and summarise
 
- Put data frame in a table
- Remove the meanFreq() columns
- Export the tidy data to a file
- This file will containt subject / acivity name / Variables. 
- This file will have 1 row per subject + activity name
- All variables are averges.
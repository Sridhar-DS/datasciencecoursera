# datasciencecoursera repo : README for course 3 project work : run_analysis.R script.

Source of data
-http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project data files:
-https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Prepare a consolidated dataset

- The data files for this activity are X_train and X_test
- The files contain data for all the variables
- Read the training,test and features data
- Merge the training and test datasets


## Fetch the column names and retain only the mean and sd variable names

- The data for this is available in features.txt
- The file contain all the variable names
- Get all column names and apply to the dataset
- Retain only the mean and standard deviation columns in the dataset


## Prepare the subject and activity variables

- 1. The data for this step is avaible in y_test.txt,y_train.txt and activity_labels.txt
- 2. The y_train.txt and y_test.txt files mention the type of activities done by the subjects
- 3. The activity_labels.txt file maps the acivity id to descriptive labels of acivities
- 4. Prepare activity variable values for training and test datasets
- 5. Prepare subject variable values for training and test datasets
- 6. Prepare column labels for subject and activity
- 7. Prepare the datset with the subjects and activities data
- 8. rename the activity column to activity.name
- 9. Update the dataset with descriptive names for acivity based on lookup file

 
## Consolidation of variables,subject,activty in a data frame

- Join the actual dataset with descriptive labels dataset

## Transfer the data to a table and summarise
 
- Put data frame in a table
- Remove the meanFreq() columns
- Export the tidy data to a file
- This file will containt subject / acivity name / Variables. 
- This file will have 1 row per subject + activity name
- All variables are averges.

## How to run this program ?

- Put the run_analysis.R in working directory
- Place the data files (X_train.txt ,X_test.txt,features.txt,y_train.txt and y_test.txt) as above. 

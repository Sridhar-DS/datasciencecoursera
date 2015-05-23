# datasciencecoursera : Cookbook for course 3 project work

## R program name

- run_analysis.R

## Data files 

- X_train.txt : 7352 observations, 561 variables
- X_test.txt  : 2947 observations, 561 variables
- features.txt:  561 observations, 2 variables
- y_train.txt : 7352 observations, 1 variable
- y_test.txt  : 2947 observations, 1 variable
- activity_labels.txt : 6 observations, 2 variables

## Explantion about data file contents (variables and their meanings)

- This can be inferred from features.txt and README.txt that comes in the zip file.

## Structure of data in final dataset

- The data is present in tablular format.
- There are 68 columns in the dataset.
- The first two columns are subjects and activity name.
- The subject is a numeric column. Activity name is a character column.
- The remaining columns are variables measured from the experiment. These are numeric values.
- The variables either represent sd or mean value of the measure.
- There will be one observation per subject and activity combination.
- There are 180 observations in the dataset.

## Variables in the final dataset

- Subject
- activity.name
- tBodyAcc-mean()-X
- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()
- fBodyBodyGyroJerkMag-std()

# How to cleanse the data and get a tidy dataset

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

## How to run this R script?

- Put the run_analysis.R in working directory
- Place the data files (X_train.txt ,X_test.txt,features.txt,y_train.txt and y_test.txt) as above. 

## read the training,test and features data 

a.train<-read.table("./X_train.txt",head=FALSE)
a.test<-read.table("./X_test.txt",head=FALSE)
a.features<-read.table("./features.txt",head=FALSE)

## merge the tarining and test datasets.

train_test<-rbind(a.train,a.test)

## get all column names and apply to the dataset
a.cols<-a.features$V2
cols<-as.character(a.cols)
colnames(train_test)<-c(cols)

## retain only the mean and standard deviation columns in the dataset

my_cols<-grep("std()|mean()",cols)
train.test<-train_test[,c(my_cols)]

## Make the dataset tidy by bringing in the subject and activity names

## 1. Prepare activity variable values for training and test datasets

train.labels.tmp<-read.table("./y_train.txt",head=FALSE)
test.labels.tmp<-read.table("./y_test.txt",head=FALSE)
train.test.labels.tmp<-rbind(train.labels.tmp,test.labels.tmp)

## 2. Prepare subject variable values for training and test datasets

train.subjects.tmp<-read.table("./subject_train.txt",head=FALSE)
test.subjects.tmp<-read.table("./subject_test.txt",head=FALSE)
train.test.subjects.tmp<-rbind(train.subjects.tmp,test.subjects.tmp)

## 3. Prepare column labels for subject and activity

colnames(train.test.subjects.tmp)<-"Subject"
colnames(train.test.labels.tmp)<-"activity"

## 4. Prepare the datset with the subjects and activities data

tt.sub.act<-cbind(train.test.subjects.tmp,train.test.labels.tmp,train.test.labels.tmp)

## 5. rename the activity column to activity.name

colnames(tt.sub.act)[3]<-"activity.name"

## 6. Update the dataset with descriptive names for acivity based on lookup file

for (i in 1:nrow(tt.sub.act)) {
               if(tt.sub.act$activity[i]==1) {
                   tt.sub.act$activity.name[i]<-"WALKING"
               }
               if(tt.sub.act$activity[i]==2) {
                   tt.sub.act$activity.name[i]<-"WALKING_UPSTAIRS"
               }
               if(tt.sub.act$activity[i]==3) {
                   tt.sub.act$activity.name[i]<-"WALKING_DOWNSTAIRS"
               }
               if(tt.sub.act$activity[i]==4) {
                   tt.sub.act$activity.name[i]<-"SITTING"
               }
               if(tt.sub.act$activity[i]==5) {
                   tt.sub.act$activity.name[i]<-"STANDING"
               }
               if(tt.sub.act$activity[i]==6) {
                   tt.sub.act$activity.name[i]<-"LAYING"
               }
}

subject.labels<-tt.sub.act[,c(1,3)]

## Join the actual dataset with descriptive labels dataset

ds<-cbind(subject.labels,train.test)

## Put data frame in a table

mytab.tmp<-tbl_df(ds)

## Remove the meanFreq() columns

mytab<-select(mytab.tmp,-c(49,50,51,58,59,60,67,68,69,72,75,78,81))

## Export the tidy data to a file
## This file will containt subject / acivity name / Variables. 
## This file will have 1 row per subject + activity name
## All variables are averges.

mytab.grp.mean<-mytab %>% group_by(Subject,activity.name)%>%summarise_each(funs(mean))





Reproducible research - Assignment 1
========================================================


#  0.0 Invoke the required libraries


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
library(lubridate)
library(tidyr)
options(digits=12)
```

#  0.1 Download the file and read it


```r
###############################################################################
### Download the file from web
###############################################################################

## Find out the file location i.e. URL and the file name

file_url<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
file<-"repdata-data-activity.zip"

## Download the file to the working directory

if (!file.exists(file)) {
        download.file(file_url, destfile = file) 
}

## Unzip the file 

unzip(file, overwrite=TRUE)

## Read the file

dat<-read.csv("./activity.csv",head=TRUE,sep=",")

## Convert date factor to date , interval integer to hm

dat$date<-as.POSIXct(as.character(levels(dat$date)), format = "%Y-%m-%d")[dat$date]
```

#  1.1  Total number of steps taken per day ?


```r
###############################################################################
## Part 1 of the assignment
###############################################################################

## convert the df to table

my_tbl<-tbl_df(dat)

## group by date after removing NA rows

by_date<-my_tbl %>%
        na.omit() %>%
        group_by(date)

## Total number of  steps taken by date

daywise<-summarise(by_date,tot_steps=sum(steps,na.rm=TRUE))

ggplot(data=daywise,aes(x=date,y=tot_steps)) + 
        geom_line(colour="blue")+
        labs(title="Total number of steps taken per day") +
        labs(x="Date", y="Total steps")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

#  1.2 Histogram of the total number of steps taken each day ?


```r
## Plot the histogram for steps walked

ggplot(data=daywise,aes(x=tot_steps)) + 
        geom_histogram(binwidth=2000 , colour="black", fill="thistle1") +        
        labs(title="Histogram for total steps ") +
        labs(x="Number of daily steps", y="Frequency")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

#  1.3 Mean total steps taken per day ?


```r
## Mean and Median steps by day

summary.steps<-summarise(by_date,mean_steps=mean(steps),median_steps=median(steps))

summary.steps1<-gather(summary.steps,summary_name, summary_value,2:3)

ggplot(data=summary.steps1,aes(x=date,y=summary_value,colour=summary_name)) + 
        geom_line()+
        labs(title="Mean & Median steps taken per day") +
        labs(x="Date", y="Total steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 


#  2.1 Time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis) ?


```r
## Format the interval values.

my_tbl2<-mutate(my_tbl,new_interval=as.character(interval))
my_tbl2$new_interval<- ifelse(my_tbl2$interval<=5,paste("00:0",my_tbl2$new_interval,":00",sep=""),my_tbl2$new_interval)
my_tbl2$new_interval<- ifelse(my_tbl2$interval>5 & my_tbl2$interval<100,paste("00:",my_tbl2$new_interval,":00",sep=""),my_tbl2$new_interval)
my_tbl2$new_interval<- ifelse(my_tbl2$interval>=100 & my_tbl2$interval<=955, paste("0",substr(my_tbl2$new_interval,1,1),":",substr(my_tbl2$new_interval,2,3),":00",sep=""),my_tbl2$new_interval)
my_tbl2$new_interval<- ifelse(my_tbl2$interval>955,paste(substr(my_tbl2$new_interval,1,2),":",substr(my_tbl2$new_interval,3,4),":00",sep=""),my_tbl2$new_interval)
my_tbl2$new_interval<-as.POSIXct(my_tbl2$new_interval,format='%H:%M:%S')

## Find the average steps by interval (across days)

intwise<-my_tbl2 %>%
na.omit() %>%
group_by(interval) %>%
summarise(tot_steps=mean(steps))

## Make the timeseries plot for average steps across days by interval

ggplot(intwise,aes(x=interval,y=tot_steps)) +
        geom_line() +        
        labs(title="Time series : Average number of steps taken averaged across days") +
        labs(x="Interval", y="Steps")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

#  2.2 Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps ?


```r
## which interval got max steps

max_steps<-summarize(intwise,mi=max(tot_steps))

max_steps_interval<-subset(intwise,tot_steps==max_steps$mi)

print(paste("Max steps observed at interval ",max_steps_interval$interval, "max steps = ",max_steps_interval$tot_steps ))
```

```
## [1] "Max steps observed at interval  835 max steps =  206.169811320755"
```

#  3.1 Calculate and report the total number of missing values in the dataset ?


```r
## Number of rows where values are null. Report by column.
na_counts<- colSums(is.na(dat)) 

print(paste("Number of rows with NA values for steps : ",na_counts[1]))
```

```
## [1] "Number of rows with NA values for steps :  2304"
```

#  3.2 Devise a strategy for filling in all of the missing values in the dataset ?


```r
print(paste("Strategy for fixing NA values for steps : ","Applied mean for that 5-minute interval across days"))
```

```
## [1] "Strategy for fixing NA values for steps :  Applied mean for that 5-minute interval across days"
```


#  3.3 Create a new dataset that is equal to the original dataset but with the   missing data filled in. ?


```r
## Find the average steps for every 5 minute interval.

row.has.na <- apply(dat, 1, function(x){any(is.na(x))})
rows.with.na <- dat[row.has.na,]
rows.without.na <- dat[!row.has.na,]
my_tbl3<-tbl_df(rows.without.na)
by_int<-group_by(my_tbl3,interval)

## Lookup values with mean steps for each interval

interval.wise<-summarise(by_int,mean_steps=mean(steps))

## Prepare two datasets. One with NA values. Other without NA values

rows.without.na2 <- dat[!row.has.na,]
rows.with.na2 <- dat[row.has.na,]

## Convert the integer column to numeric

rows.with.na2$steps<-as.numeric(rows.with.na2$steps)
rows.without.na2$steps<-as.numeric(rows.without.na2$steps)

## Using dataset interval.wise as lookup...update the base dataset
## Lookup and replace NA values

for(i in 1:nrow(rows.with.na2)) {
        rows.with.na2[i,]$steps <- interval.wise[interval.wise$interval %in% rows.with.na2[i,]$interval,]$mean_steps
}

## Merge the two data frames and prepare a final data set

data.final<- rbind(rows.with.na2,rows.without.na2)

Print("The dataset with values replaced for NA is named as data.final")
```

```
## Error in eval(expr, envir, enclos): could not find function "Print"
```

#  3.4 Make a histogram of the total number of steps taken each day ?


```r
## convert the df to table

my_tbl4<-tbl_df(data.final)

## group dataset by date

by_date4<-group_by(my_tbl4,date)

## summarise the steps by date

daywise4<-summarise(by_date4,tot_steps=sum(steps))

## Plot the histogram after NA's are replaced

ggplot(data=daywise4,aes(x=tot_steps)) + 
        geom_histogram(binwidth=2000 , colour="black", fill="thistle1") +        
        labs(title="Histogram for Total steps taken each day : Post NA fix") +
        labs(x="Number of daily steps", y="Frequency")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

#  3.5 Calculate and report the mean and median total number of steps taken per day ?


```r
## Comparison of mean and median steps : Before and after NA cleanup

summary.steps.temp1<-summarise(by_date,mean_na_ignored=mean(steps),median_na_ignored=median(steps))

summary.steps.temp2<-summarise(by_date4,mean_na_replaced=mean(steps),median_na_replaced=median(steps))

summary.gather1<-gather(summary.steps.temp1,summary_name, summary_value,2:3)

summary.gather2<-gather(summary.steps.temp2,summary_name, summary_value,2:3)

summary.gather.total<-rbind(summary.gather1,summary.gather2)


ggplot(data=summary.gather.total,aes(x=date,y=summary_value)) + 
        geom_line(size=1,colour="blue")+
        facet_wrap( ~ summary_name, ncol=1) +
        labs(title="Comparison of Mean & Median steps by day : Before and after NA cleanup") +
        labs(x="Date", y="Total steps")+
        theme(strip.text.x = element_text(size=14, face="bold"),
              strip.text.y = element_text(size=14, face="bold"),
              strip.background = element_rect(colour="red", fill="#CCCCFF"))
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png) 

#  3.6 Do these values differ from the estimates from the first part of the assignment?


```r
print("The mean steps taken per day appears same before and after NA fix")
```

```
## [1] "The mean steps taken per day appears same before and after NA fix"
```

```r
print("The median steps taken per day is different only for days where NA has been replaced.")
```

```
## [1] "The median steps taken per day is different only for days where NA has been replaced."
```

#  3.7 What is the impact of imputing missing data on the estimates of the total daily number of steps?


```r
## Comparison of total steps per day : Before and after NA cleanup

daywise_before_na_cleanup<-summarise(by_date,tot_steps_pre_cleanup=sum(steps,na.rm=TRUE))

daywise_after_na_cleanup<-summarise(by_date4,tot_steps_post_cleanup=sum(steps))

daywise_consolidated<-full_join(daywise_before_na_cleanup,daywise_after_na_cleanup,by="date")

daywise.gather<-gather(daywise_consolidated,summary_name, summary_value,2:3)

ggplot(data=daywise.gather,aes(x=date,y=summary_value)) + 
        geom_line(size=1,colour="blue")+
        facet_wrap( ~ summary_name, ncol=1) +
        labs(title="Comparison of total steps by day : Before and after NA cleanup") +
        labs(x="Date", y="Total steps")+
        theme(strip.text.x = element_text(size=14, face="bold"),
              strip.text.y = element_text(size=14, face="bold"),
              strip.background = element_rect(colour="red", fill="#CCCCFF"))
```

```
## Warning in loop_apply(n, do.ply): Removed 2 rows containing missing values
## (geom_path).
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png) 

```r
print("There is no impact on replacing NA values. Reason : If a NA was observed for an interval..the it is seen for that entire day. Then the impacted days got values from average of that interval across days. There were'nt a case where NA values and total steps were observed within a day. ")
```

```
## [1] "There is no impact on replacing NA values. Reason : If a NA was observed for an interval..the it is seen for that entire day. Then the impacted days got values from average of that interval across days. There were'nt a case where NA values and total steps were observed within a day. "
```

# 4.1  Are there differences in activity patterns between weekdays and weekends?


```r
## Add wk_ind column to the clean dataset (one without NA's)

my_tbl5<-my_tbl4
my_tbl6<-mutate(my_tbl5,
        wk_ind = ifelse(weekdays(my_tbl5$date) %in% c("Sunday","Saturday"), "weekend","weekday" ))
intwise6<-my_tbl6 %>%
        group_by(interval,wk_ind) %>%
        summarise(tot_steps=mean(steps))

## Make the timeseries plot with clean data.

ggplot(intwise6,aes(x=interval,y=tot_steps,group=wk_ind)) +
        geom_line(colour="blue") +
        labs(title="Time series for total steps") +
        labs(x="Interval", y="Number of steps") +
        facet_wrap( ~ wk_ind, ncol=1) +
        theme(strip.text.x = element_text(size=14, face="bold"),
              strip.text.y = element_text(size=14, face="bold"),
              strip.background = element_rect(colour="red", fill="#CCCCFF"))
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15-1.png) 

```r
print("Yes there is a difference in activity levels between  weekdays and weekends. ")
```

```
## [1] "Yes there is a difference in activity levels between  weekdays and weekends. "
```

README.md


Script: run_analysis.R

Setup:
	1.  Download dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	
	2.  Uncompress to c:\ - creates subirectory UCI HAR Dataset directory and extracts files

	3.  Copy run_analysis.R script to C:\UCI HAR Dataset directory
	
	4.  Execute from R Studio



Script Details

1.  Loads required librarys (sqldf,plyr)

2.  Sets working directory to location of data

3.  Reads "features.txt" and assigns column names - features list

4.  Reads "activity_labels.txt" and assigns column names - Links the class labels with their activity names

5.  Reads "x_train.txt" and assigns column names - Training data set

6.  Creates column train_recnum based on record number and appends to beginning of data frame to act as identifier

7.  Read "y_train.txt" and assign column names - Training labels

8.  Read "subject_train.txt" and assign column names - Identifies subject who performed activity

9.  Creates column subject_recnum based on record number and appends to beginning of data frame to act as identifier

10.  Creates column activity_recnum based on record number and appends to beginning of data frame to act as identifier

11.  Update train activity data frame with actual activity which matches the activity code

12.  Merge train and train activity data frames based on recnum fields created above

13.  Merge output of 12 and subject train data frames based on recnum fields created above

14.  Reads "y_test.txt" and assigns column names - Test data set

15.  Creates column train_recnum based on record number and appends to beginning of data frame to act as identifier

16.  Read "subject_test.txt" and assign column names - Identifies subject who performed activity

17.  Creates column subject_recnum based on record number and appends to beginning of data frame to act as identifier

18.  Creates column activity_recnum based on record number and appends to beginning of data frame to act as identifier

19.  Update test activity data frame with actual activity which matches the activity code

20.  Merge test and test activity data frames based on recnum fields created above  

21.  Merge output of 20 and subject test data frames based on recnum fields created above

22.  Merge test and train data sets together and remove recnum and activity code fields

23.  Subset combined data frame to only include Subject ID, Activity, Mean and Standard Deviation fields

24.  Creates data frame with columns grouped by Subject ID and Activity

25.  Writes train_test_mean_stddev.csv file - data frame from step 23

26.  Wrotes train_test_subject_activity_mean.csv - data frame from step 24


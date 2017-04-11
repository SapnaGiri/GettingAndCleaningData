The run_analysis.R file contains R script used to read and clean the data from “UCI HAR Dataset” along with different 
transformations performed on the data finally resulting in the “GettingAndCleaningData.txt” file.

‘dplyr’ package is loaded using library(dplyr). 

The data from various text files in the source are read using read.table(). These are stored in below R objects 
activity_labels
features
subject_train
y_train
X_train
subject_test 
y_test
X_test


A character vector ‘activity’ is created with column V2 from activity_labels.

The single column in subject_train and subject_test is named ‘subject’ using names().

Data frames activity_train and activity_test are created wherein the activity id in y_train and y_test are transformed into respective activitys label using activity vector.

The columns in X_train and X_test are named using data from column V2 in features.

‘traindata’ and ‘testdata’ are created by combining columns from subject_XXX, activity_XXX and X_XXX data sets using cbind().

Then traindata and testdata are merged into ‘alldata’ using rbind().

To extract only the columns having the mean and std measurements from alldata, first create a vector ‘allcolumnnames’ having all the column names in alldata.
Using grep() get all the column names for mean and std measurements into ‘meanandstdcolumns’.

Finally using the column names from above step get the required data into ‘meanAndStdData’  along with subject and activity columns.

Then from the above dataset ‘meanAndStdData’ to get the mean of each variable for each activity and each subject, 
first group the data by subject and activity using group_by() and store the result in ‘by_subject_activity’.

Use summarize_each() to find the mean of each variable in ‘by_subject_activity’ and store the resulting data in ‘variableMeansBySubjectActivity’.

Finally store the data in ‘variableMeansBySubjectActivity’ in a text file using write.text().

 





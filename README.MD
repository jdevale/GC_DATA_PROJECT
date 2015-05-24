---
title: "ReadMe - Getting and Cleaning Data course project"
author: "jdevale"
date: "05/22/2015"
output: html_document
---


This summarized Tidy Data Set contains summary data from the original set:


>Human Activity Recognition Using Smartphones Dataset
>Version 1.0
>
>Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
>Smartlab - Non Linear Complex Systems Laboratory
>DITEN - Universit?? degli Studi di Genova.
>Via Opera Pia 11A, I-16145, Genoa, Italy.
>activityrecognition@smartlab.ws
>www.smartlab.ws

***
Data is summarized by the script: run_analysis.R

There is a single script which performs all the work to including joining data sets, subsetting just the calculated MEAN and STD values, and then calculating group means by SubjectID and Activity.  The basic script flow is as follows:

1. Read Samsung phone data
2. Join test and train data sets, combining all XYZ measurements in a single row with subject ID and activity
3. Subsets the measurement data for only mean and standard deviation of each measure
4. Creates a tidy data set with only the average of measurements by each subject-activity pair
5. Creates appropriate column labels and updates activity to be human readable text

Data processing and organization is done primarily using the DPLYR package.  Once the data is read in and converted to dplyr tables they are joined together using bind_col() so that both test and train data sets have all XYZ measurements in a single row which includes the subject and activity.  The train and test data sets are then joined using rbind() into a combined data table.  Variable (column) names are read from the features text file and converted to acceptable name text using make.names(), and are applied to the combine table.  Subject activity in human readable form is added to the combined data table using mutate(), and then the table is reordered so that subjectID and Activity(human readable) are the first two columns, followed by the data observations.  Activity in numerical form is omitted. Data selection is performed using the select() function with the contains() helper function to select columns with "mean" and "std" in their text.  The resulting table is then grouped by SubjectID and Activity, and then summarise_all() is applied to generate means() by the applied grouping.
 
This script is run within the UCI HAR Dataset directory and assumes the data has been downloaded and unpacked.

This resulting data set is TIDY, and conforms to the tidy data requirements of:

1. Each variable is in its own column
2. Each observation is in its own row
3. There is a single table, with one kind of data
4. Not applicable as all the data is the same kind, and thus in a single table

For full information on tidy data please refer to:  
Hadley Wickham, Tidy data,  The Journal of Statistical Software, vol. 59, 2014.
http://vita.had.co.nz/papers/tidy-data.pdf

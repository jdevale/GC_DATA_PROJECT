---
title: "Codebook For Getting and Cleaning Data course project"
author: "jdevale"
date: "05/22/2015"
output: html_document
---
##General Information
###Data organization and processing steps
The data is organized as a tidy set with each row containing sensor data for one activity for one participant.  Thus there are multiple rows of data for each participant.  

Data processing and organization is done primarily using the DPLYR package.  Once the data is read in and converted to dplyr tables they are joined together using bind_col() so that both test and train data sets have all XYZ measurements in a single row which includes the subject and activity.  The train and test data sets are then joined using rbind() into a combined data table.  Variable (column) names are read from the features text file and converted to acceptable name text using make.names(), and are applied to the combine table.  Subject activity in human readable form is added to the combined data table using mutate(), and then the table is reordered so that subjectID and Activity(human readable) are the first two columns, followed by the data observations.  Activity in numerical form is omitted. Data selection is performed using the select() function with the contains() helper function to select columns with "mean" and "std" in their text.  The resulting table is then grouped by SubjectID and Activity, and then summarise_all() is applied to generate means() by the applied grouping.

###Column Details
Column 1 contains the subject ID, and is of class Integer.  Column 2 contains a human readable descriptions of the activity and is of class character. 

All other columns contain the mean of all mean and standard deviation measurements for the indicated subject for all trials of the indicated activity.  Data is normalized to [-1:1] and represents the values measured by the phone accelerometer and gyro.  Time domain data is indicated in the descriptive variable name by the inclusion of "timeDomainSignal".  The corresponding frequency response of the time domain data is indicated with the inclusion of "frequencyDomainSignal" in the descriptive variable name.  Columns containing "angleBetween" represent the angle between the measured vector and its corresponding gravity vector component.

###Comments on Units
As the summary operations only took the mean of observations already specified in the original work, the units have not changed from those specified by the orignial authors.


>The reason for the summary choice of taking the mean of STD and MEAN experimental observations was to conform to the project requirements.

***

##Codebook

Variable Index | Data Type | Descriptive Variable Name
---------------|-----------|----------------------------------------------------------------------------------------------------------
 1 | integer | SubjectID
 2 | character | Activity
 3 | numeric | timeDomianSignal.angleBetween.MeanOfBodyAccelerometerVectorJerk.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 4 | numeric | timeDomianSignal.angleBetween.MeanOfBodyAccelerometerVector.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 5 | numeric | timeDomianSignal.angleBetween.MeanOfBodyGyroVectorJerk.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 6 | numeric | timeDomianSignal.angleBetween.MeanOfBodyGyroVector.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 7 | numeric | angleBetween.X.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 8 | numeric | angleBetween.Y.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
 9 | numeric | angleBetween.Z.and.Gravity..computerMeanOfSpecificSubject_ActivityPair
10 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.meanFreq...X.computedMeanOfSpecificSubject_ActivityPair
11 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.meanFreq...Y.computedMeanOfSpecificSubject_ActivityPair
12 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.meanFreq...Z.computedMeanOfSpecificSubject_ActivityPair
13 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...X.computedMeanOfSpecificSubject_ActivityPair
14 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...Y.computedMeanOfSpecificSubject_ActivityPair
15 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...Z.computedMeanOfSpecificSubject_ActivityPair
16 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...X.computedMeanOfSpecificSubject_ActivityPair
17 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...Y.computedMeanOfSpecificSubject_ActivityPair
18 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...Z.computedMeanOfSpecificSubject_ActivityPair
19 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Mag.mean...computedMeanOfSpecificSubject_ActivityPair
20 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Mag.meanFreq...computedMeanOfSpecificSubject_ActivityPair
21 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer.Mag.std...computedMeanOfSpecificSubject_ActivityPair
22 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..meanFreq...X.computedMeanOfSpecificSubject_ActivityPair
23 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..meanFreq...Y.computedMeanOfSpecificSubject_ActivityPair
24 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..meanFreq...Z.computedMeanOfSpecificSubject_ActivityPair
25 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..mean...X.computedMeanOfSpecificSubject_ActivityPair
26 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..mean...Y.computedMeanOfSpecificSubject_ActivityPair
27 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..mean...Z.computedMeanOfSpecificSubject_ActivityPair
28 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..std...X.computedMeanOfSpecificSubject_ActivityPair
29 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..std...Y.computedMeanOfSpecificSubject_ActivityPair
30 | numeric | frequencyDomainSignal.Body.asMeasuredByAccelerometer..std...Z.computedMeanOfSpecificSubject_ActivityPair
31 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..meanFreq...X.computedMeanOfSpecificSubject_ActivityPair
32 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..meanFreq...Y.computedMeanOfSpecificSubject_ActivityPair
33 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..meanFreq...Z.computedMeanOfSpecificSubject_ActivityPair
34 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..mean...X.computedMeanOfSpecificSubject_ActivityPair
35 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..mean...Y.computedMeanOfSpecificSubject_ActivityPair
36 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..mean...Z.computedMeanOfSpecificSubject_ActivityPair
37 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..std...X.computedMeanOfSpecificSubject_ActivityPair
38 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..std...Y.computedMeanOfSpecificSubject_ActivityPair
39 | numeric | frequencyDomainSignal.Body.asMeasuredByGyroscope..std...Z.computedMeanOfSpecificSubject_ActivityPair
40 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByAccelerometer.JerkMag.mean...computedMeanOfSpecificSubject_ActivityPair
41 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByAccelerometer.JerkMag.meanFreq...computedMeanOfSpecificSubject_ActivityPair
42 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByAccelerometer.JerkMag.std...computedMeanOfSpecificSubject_ActivityPair
43 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.JerkMag.mean...computedMeanOfSpecificSubject_ActivityPair
44 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.JerkMag.meanFreq...computedMeanOfSpecificSubject_ActivityPair
45 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.JerkMag.std...computedMeanOfSpecificSubject_ActivityPair
46 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.Mag.mean...computedMeanOfSpecificSubject_ActivityPair
47 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.Mag.meanFreq...computedMeanOfSpecificSubject_ActivityPair
48 | numeric | frequencyDomainSignal.BodyBody.asMeasuredByGyroscope.Mag.std...computedMeanOfSpecificSubject_ActivityPair
49 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.JerkMag.mean...computedMeanOfSpecificSubject_ActivityPair
50 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.JerkMag.std...computedMeanOfSpecificSubject_ActivityPair
51 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...X.computedMeanOfSpecificSubject_ActivityPair
52 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...Y.computedMeanOfSpecificSubject_ActivityPair
53 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.mean...Z.computedMeanOfSpecificSubject_ActivityPair
54 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...X.computedMeanOfSpecificSubject_ActivityPair
55 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...Y.computedMeanOfSpecificSubject_ActivityPair
56 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Jerk.std...Z.computedMeanOfSpecificSubject_ActivityPair
57 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Mag.mean...computedMeanOfSpecificSubject_ActivityPair
58 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer.Mag.std...computedMeanOfSpecificSubject_ActivityPair
59 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..mean...X.computedMeanOfSpecificSubject_ActivityPair
60 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..mean...Y.computedMeanOfSpecificSubject_ActivityPair
61 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..mean...Z.computedMeanOfSpecificSubject_ActivityPair
62 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..std...X.computedMeanOfSpecificSubject_ActivityPair
63 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..std...Y.computedMeanOfSpecificSubject_ActivityPair
64 | numeric | timeDomainSignal.Body.asMeasuredByAccelerometer..std...Z.computedMeanOfSpecificSubject_ActivityPair
65 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.JerkMag.mean...computedMeanOfSpecificSubject_ActivityPair
66 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.JerkMag.std...computedMeanOfSpecificSubject_ActivityPair
67 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.mean...X.computedMeanOfSpecificSubject_ActivityPair
68 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.mean...Y.computedMeanOfSpecificSubject_ActivityPair
69 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.mean...Z.computedMeanOfSpecificSubject_ActivityPair
70 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.std...X.computedMeanOfSpecificSubject_ActivityPair
71 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.std...Y.computedMeanOfSpecificSubject_ActivityPair
72 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Jerk.std...Z.computedMeanOfSpecificSubject_ActivityPair
73 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Mag.mean...computedMeanOfSpecificSubject_ActivityPair
74 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope.Mag.std...computedMeanOfSpecificSubject_ActivityPair
75 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..mean...X.computedMeanOfSpecificSubject_ActivityPair
76 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..mean...Y.computedMeanOfSpecificSubject_ActivityPair
77 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..mean...Z.computedMeanOfSpecificSubject_ActivityPair
78 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..std...X.computedMeanOfSpecificSubject_ActivityPair
79 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..std...Y.computedMeanOfSpecificSubject_ActivityPair
80 | numeric | timeDomainSignal.Body.asMeasuredByGyroscope..std...Z.computedMeanOfSpecificSubject_ActivityPair
81 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer.Mag.mean...computedMeanOfSpecificSubject_ActivityPair
82 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer.Mag.std...computedMeanOfSpecificSubject_ActivityPair
83 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..mean...X.computedMeanOfSpecificSubject_ActivityPair
84 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..mean...Y.computedMeanOfSpecificSubject_ActivityPair
85 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..mean...Z.computedMeanOfSpecificSubject_ActivityPair
86 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..std...X.computedMeanOfSpecificSubject_ActivityPair
87 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..std...Y.computedMeanOfSpecificSubject_ActivityPair
88 | numeric | timeDomainSignal.Gravity.asMeasuredByAccelerometer..std...Z.computedMeanOfSpecificSubject_ActivityPair



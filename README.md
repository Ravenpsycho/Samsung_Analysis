#################################################
## Wearable Device activity data manipulation ###
#################################################

The script run_analysis.R will go through a directory, supposedly named "UCI HAR  
Dataset". It will gather two main data files (./test/X_test.txt and  
./train/X_train.txt), as well as their labels and subject ID's in other files.

It will then merge both datasets using the rbind function.

After that, it will reduce the number of variables, keeping only the ones  
containing either "mean()" or "std()" in their names (respectively means and  
standard deviations) THE FACT THAT COLUMNS CONTAINING MeanFreq() IS DELIBERATE,  
since it can lead to confusion and was not requested in the assignment.  

This makes the variables number drop from 561 to 66 (plus 2 for the subject and  
activity).  
  
Finally, it will use the package dplyr to create another data frame containing  
the means of each variable, grouped by activity and by subject (resulting in  
means of mean and means of standard deviations) in a very compact and (hopefully)  
lisible format.  
  
The values of the output file (in the freshly(?) created "/output" directory) are  
therefore the means of several of the values gathered in the original files,  
grouped by subject and activity.  
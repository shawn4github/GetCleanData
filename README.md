***  
## [Course Project - Read Me] Getting and Cleaning Data
### Data Science Specialization on Coursera
***  
**Ian Huang**     
shuang4csa@hotmail.com    

***  

**The purpose of this project is to demonstrate the ability to collect, work with, and clean a dataset. The goal is to prepare tidy data that can be used for later analysis.** 

**Tidy datasets are easy to manipulate, model and visualize, and have a specific structure: **  
**1. each variable is a column,**    
**2. each observation is a row, and**   
**3. each type of observational unit is a table.**   

The source data can be found here:   
[https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip)

***
####The final project dataset includes the following files 
***  
* 'README.md': The document you are currently reading
* 'CodeBook.md': Shows info about the variables used on the feature vector
* 'run_analysis.R': Performs the data analysis
* 'ProcessedTidyDF_Wide.txt': Tidied data frame saved in text format

***
####How to run 'run_analysis.R'      
***
1. Download 'run_analysis.R', and save to anywhere on your local machine.
2. (Optional) Make sure the original data source folder is in your working directory. The folder name 'UCI HAR Dataset' should not be modified.
3. Open RStudio.
4. Install and load 'reshape2' package to R.
5. Source the 'run_analysis.R'.
6. 'run_analysis.R' will first check whether you have 'UCI HAR Dataset' folder in your working directory.
7. If 'UCI HAR Dataset' does not exist, it will start downloading 'UCI HAR Dataset.zip' file automatically from the designated URL and unzip to your working directory; otherwise it would use your previously downloaded 'UCI HAR Dataset' folder for later data analysis.
8. The final tidy data frame will be displayed at the end, and you will find a text format dataset 'ProcessedTidyDF_Wide.txt' saved in your working directory. 

***
####What happens during the data tidy up procedure?
***
Step 0. Check the availability of the original data source folder in your working directory.      
Step 1. Merge training and test datasets to one data frame.  
Step 2. Appropriately label the dataset with descriptive variable names.  
Step 3. Extract only the mean and standard deviation for each measurement.  
Step 4. Create a separate independent tidy dataset, which includes the average of each variable for each activity and each subject.  
Step 5. Use descriptive activity names to name the activities in the dataset.  
Step 6. Make feature names more descriptive.  
Step 7. Write the tidied dataset as a text file to your working directory.     

For more detailed procedures, please view the documentation in 'run_analysis.R'.

***
####Features and Observations in the final tidy dataset
***

**The reasons for choosing the "Wide" format for the tidied dataset are:**            
1. It will be easy to be displayed completely in RStudio without being cut-off;     
2. It has a smaller file size (1/3 the file size of the "Narrow" format file);     
3. The course project accepts both formats for submission.       

**This course project subjectively (by myself) focuses on selecting features, which have 'mean()' or 'std()' at the end of feature names.**               

Features (columns):  
* Identifiers of the volunteers who participated in the experiment  
* An activity label   
* A 18-feature vector with time and frequency domain variables for value of mean and standard deviation measured by gyroscope and accelerometer, features were normalized and bounded within the interval [-1,1].  

Observations (rows):  
* 180 records (six activities for each of the 30 volunteers)

***
####Notes
***
1. Development environment for 'run_analysis.R'    
        - Windows 7, 64-bit OS   
        - R version 3.1.2   
        - RStudio Version 0.98.1049   
2. Depending on your local machine and internet connection speed, the downloading time for 'UCI HAR Dataset.zip' may vary.
3. It takes about a runtime of 8 seconds for 'run_analysis.R' to run completely (excluding downloading time of 'UCI HAR Dataset.zip').
5. Each feature vector is a row in the text file.

For more information about this dataset contact: 
shuang4csa@hotmail.com

***
####Acknowledgements
***
[1] Hadley Wickham, Tidy Data, The Journal of Statistical Software, vol. 59, 2014.   [Tidy Data](http://vita.had.co.nz/papers/tidy-data.html)   

[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[3] David Hood, David's Project FAQs,     
[https://class.coursera.org/getdata-009/forum/thread?thread_id=58](https://class.coursera.org/getdata-009/forum/thread?thread_id=58)

[4] Human Activity Recognition Using Smartphones Data Set,    
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
***  
## [Course Project - Code Book] Getting and Cleaning Data
### Data Science Specialization on Coursera
***
####Project Background
***
The raw (input) data of this course project is a subset of the dataset of a previous project (Human Activity Recognition Using Smartphones). The brief introduction of the aforementioned project is summarized below:   

1. The experiments were carried out with a group of 30 volunteers (subjects).       
2. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).     
3. Test subjects wore a smartphone (Samsung Galaxy S II) on the waist. The experiment used its embedded accelerometer and gyroscope.    
4. The sensors captured 3-axial linear acceleration and 3-axial angular velocity.       
5. The experiment had been video-recorded to label the data manually.      
6. The obtained dataset was randomly partitioned into two sets (70% was selected as training data and 30% test data).             
7. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).     
8. The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.      
9. The gravitational force is assumed to have only low frequency components; therefore a filter with 0.3 Hz cutoff frequency was used.    
10. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.        

For more detailed information about Human Activity Recognition Using Smartphones Dataset, please view     
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

***
####Original Features
***
The features selected for the original database in the aforementioned project come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals was calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note that 'f' indicates frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Feature values on X, Y, Z directions  | Feature with magnitude values
------------- | -------------
tBodyAcc-XYZ  | __tBodyAccMag__
tGravityAcc-XYZ  | __tGravityAccMag__
tBodyAccJerk-XYZ | __tBodyAccJerkMag__
tBodyGyro-XYZ  |  __tBodyGyroMag__
tBodyGyroJerk-XYZ  |  __tBodyGyroJerkMag__
fBodyAcc-XYZ   |  __fBodyAccMag__
fBodyAccJerk-XYZ  | __fBodyAccJerkMag__
fBodyGyro-XYZ   |  __fBodyGyroMag__
fBodyGyroJerk-XYZ   |  __fBodyGyroJerkMag__

The original project source data can be found here:   
[https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip)

***  
####Feature Selection
***

This course project subjectively (by myself) focuses on selecting features only related to the **magnitude value of three-dimensional signals** (see bolded features above).   

The set of variables that were estimated from these signals are:   
  
- **mean(): Mean value**   
- **std(): Standard deviation**         

18 features (which only include 'mean()' or 'std()' at the end of feature names) were selected from the original data source, which has 561 features in total. Features values were normalized and bounded within the interval [-1,1].     

There are six activities for each of the 30 volunteers, thus resulting in 180 observations.

Features with mean values  | Features with standard deviation values
------------- | -------------
tBodyAccMag-mean()  | tBodyAccMag-std()
tGravityAccMag-mean()  | tGravityAccMag-std()
tBodyAccJerkMag-mean() | tBodyAccJerkMag-std()
tBodyGyroMag-mean()  |  tBodyGyroMag-std()
tBodyGyroJerkMag-mean()  |  tBodyGyroJerkMag-std()
BodyAccMag-mean()  |  fBodyAccMag-std()
fBodyAccJerkMag-mean()  | fBodyAccJerkMag-std()
fBodyGyroMag-mean()   |  fBodyGyroMag-std()
fBodyGyroJerkMag-mean()   |  fBodyGyroJerkMag-std()      

**The objective of this project is to get a tidy dataset with the average of each selected feature for each activity and each volunteer.**

***
####How can original feature names be made more descriptive?
***  

**Problems of original feature names:**      

1. Contains illegal characters, such as '-' and '()', which may cause trouble in R functions.       
2. Some of the feature names do not completely match their description, such as the ones containing 'BodyBody' string; It should be 'Body' in the feature names.     
3. The meanings of prefixes 't' and 'f' in feature names are not intuitive.    

**Solutions:**    

* Removed illegal characters such as '-' and '()' from feature names.
* Replaced 'BodyBody' string with 'Body' in feature names. 
* Replaced prefix 't' with 'Time' in feature names for readability.
* Replaced prefix 'f' with 'Frequency' in feature names for readability.
* Replaced 'mean' with 'MEAN' in feature names for visibility.
* Replaced 'std' with 'STD' in feature names for visibility.

Pascal case was adapted to the convention of feature names to increase readability.

**Comparison:**      

Original feature names: fBodyGyroJerkMag-mean(); tBodyAccMag-std(); tGravityAccMag-std()      
Modified feature names: FrequencyBodyGyroJerkMagMEAN; TimeBodyAccMagSTD; TimeGravityAccMagSTD     

**Abbreviations:**

- Acc: represents the device name of 'Accelerometer'      
- Gyro: represents the device name of 'Gyroscope'     
- Mag: represents 'Magnitude'    
- MEAN: represents 'Mean'    
- STD: represents 'Standard Deviation'   

***
####Features List
***  

**The following is a list of 20 features for the final project dataset:**       

>VolunteerID    
- ID number for each experiment participant (volunteer/subject)   
- Class: factor     
- Value: unique (1-30)     
- 30 Levels: 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30      

>Activity    
- Activity types    
- Class: factor   
- 6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING    

>TimeBodyAccMagMEAN      
- The mean magnitude value of time domain signals captured on body by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>TimeBodyAccMagSTD      
- The standard deviation of magnitude value of time domain signals captured on body by accelerometer    
- Class: numeric      
- Value: [-1,1]    

>TimeGravityAccMagMEAN      
- The mean magnitude value of time domain signals captured on gravity by accelerometer    
- Class: numeric      
- Value: [-1,1]      

>TimeGravityAccMagSTD      
- The standard deviation of magnitude value of time domain signals captured on gravity by accelerometer    
- Class: numeric      
- Value: [-1,1]      

>TimeBodyAccJerkMagMEAN      
- The mean magnitude value of time domain signals captured on body jerk by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>TimeBodyAccJerkMagSTD           
- The standard deviation of magnitude value of time domain signals captured on body jerk by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>TimeBodyGyroMagMEAN     
- The mean magnitude value of time domain signals captured on body by gyroscope       
- Class: numeric      
- Value: [-1,1]    

>TimeBodyGyroMagSTD     
- The standard deviation of magnitude value of time domain signals captured on body by gyroscope     
- Class: numeric      
- Value: [-1,1]    

>TimeBodyGyroJerkMagMEAN      
- The mean magnitude value of time domain signals captured on body jerk by gyroscope     
- Class: numeric      
- Value: [-1,1]  
   
>TimeBodyGyroJerkMagSTD      
- The standard deviation of magnitude value of time domain signals captured on body jerk by gyroscope     
- Class: numeric      
- Value: [-1,1]  

>FrequencyBodyAccMagMEAN     
- The mean magnitude value of frequency domain signals captured on body by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>FrequencyBodyAccMagSTD     
- The standard deviation of magnitude value of frequency domain signals captured on body by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>FrequencyBodyAccJerkMagMEAN      
- The mean magnitude value of frequency domain signals captured on body jerk by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>FrequencyBodyAccJerkMagSTD          
- The standard deviation of magnitude value of frequency domain signals captured on body jerk by accelerometer     
- Class: numeric      
- Value: [-1,1]    

>FrequencyBodyGyroMagMEAN      
- The mean magnitude value of frequency domain signals captured on body by gyroscope       
- Class: numeric      
- Value: [-1,1]    

>FrequencyBodyGyroMagSTD      
- The standard deviation of magnitude value of frequency domain signals captured on body by gyroscope       
- Class: numeric      
- Value: [-1,1]   

>FrequencyBodyGyroJerkMagMEAN       
- The mean magnitude value of frequency domain signals captured on body jerk by gyroscope     
- Class: numeric      
- Value: [-1,1]  

>FrequencyBodyGyroJerkMagSTD        
- The standard deviation of magnitude value of frequency domain signals captured on body jerk by gyroscope     
- Class: numeric      
- Value: [-1,1]  

***
####Acknowledgements
***
[1] Hadley Wickham, Tidy Data, The Journal of Statistical Software, vol. 59, 2014.   [Tidy Data](http://vita.had.co.nz/papers/tidy-data.html)   

[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[3] David Hood, David's Project FAQs,     
[https://class.coursera.org/getdata-009/forum/thread?thread_id=58](https://class.coursera.org/getdata-009/forum/thread?thread_id=58)

[4] Human Activity Recognition Using Smartphones Data Set,    
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
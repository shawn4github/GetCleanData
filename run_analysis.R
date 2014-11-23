## RuntimePerformance <- system.time({
## The line above is a system function to test on runtime performance
  
  ## Step 0. Check availability of the original data source folder in your working directory
  
  # Solution 1: Just check on availability of folder name - "UCI HAR Dataset"
  if (!file.exists("./UCI HAR Dataset")) {
    fileURL<-"https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "UCI HAR Dataset.zip", mode = "wb") 
    unzip("./UCI HAR Dataset.zip",exdir=getwd())
  }
  
  # Solution 2: Check on folders' structure on "UCI HAR Dataset"
  # if (length(grep("^./UCI HAR Dataset",list.dirs()))!=5) {
  #   fileURL<-"https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
  #   download.file(fileURL, destfile = "UCI HAR Dataset.zip", mode = "wb") 
  #   unzip("./UCI HAR Dataset.zip",exdir=getwd())
  # }
  
  ## Step 1. Merge training and test datasets to one data frame.
  
  # Get a list of all ".txt" files in test folder
  TestFileList <- list.files("./UCI HAR Dataset/test", pattern="\\.txt$",full.names=TRUE) 
  
  # Get a list of all ".txt" files in train folder
  TrainFileList <- list.files("./UCI HAR Dataset/train", pattern="\\.txt$", full.names=TRUE)
  
  # Read all 3 .txt files from the TestFileList and cbind them together, set up colClasses,comment.char in order to read faster
  TestDF_RAW <- data.frame(sapply(TestFileList,function(x) cbind(read.table(x,colClasses ="numeric",comment.char=""))))
  
  # Read all 3 .txt files from the TrainFileList and cbind them together, set up colClasses,comment.char in order to read faster
  TrainDF_RAW <- data.frame(sapply(TrainFileList,function(x) cbind(read.table(x,colClasses ="numeric",comment.char=""))))
  
  # Combine train and test data frames together (convert to matrix first to avoid match.name checking) 
  DF_RAW <- data.frame(rbind(as.matrix(TrainDF_RAW),as.matrix(TestDF_RAW)))
  
  ## Step 2. Appropriately label the dataset with descriptive variable names.
  
  # Read features label to R
  Features <- read.table("./UCI HAR Dataset/features.txt")
  
  # Compose column names and assign it to DF_RAW
  names(DF_RAW) <- c("VolunteerID",as.character(Features[,2]),"Activity")
  
  ## Step 3. Extract only the measurements on the mean and standard deviation for each measurement.
  
  # Get required columns indices (search strings end with 'mean()' or 'std()' in Features)
  RequiredColIdx <- grep("mean\\(\\)$|std\\(\\)$",as.character(Features[,2]))
  
  # Subset DF_RAW to get all required columns (with 'mean()' or 'std()' at the end of columns names) 
  WorkingDF_RAW <- DF_RAW[,c(1,ncol(DF_RAW),RequiredColIdx+1)]
  
  ## Step 4. From the data WorkingDF_RAW, create an independent tidy dataset, which includes the average of each variable for each activity and each subject.
  
  # You may need to install 'reshape2' package to R here to make it work
  library(reshape2)
  
  # Melt WorkingDF_RAW, grouped by 'VolunteerID' and 'Activity', measure the features from column 3-20
  WorkingDF_RAW_Narrow <- melt(data=WorkingDF_RAW, id.vars=c("VolunteerID", "Activity"), measure.vars=names(WorkingDF_RAW)[3:20])
  
  # Compose DF_ProcessedTidy_Wide (180x20), get grouped mean value for all features except column 'VolunteerID' and 'Activity'
  DF_ProcessedTidy_Wide <- dcast(VolunteerID + Activity ~ variable, data=WorkingDF_RAW_Narrow, fun=mean)
  
  # Convert 1st column value from 'numeric' to 'factor'
  DF_ProcessedTidy_Wide$VolunteerID <- as.factor(DF_ProcessedTidy_Wide$VolunteerID)
  
  ## Step 5. Uses descriptive activity names to name the activities in the dataset.
  
  # Read activity label to R
  ActivityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  # Create a string vector contains activity label
  ActivityString <- as.character(ActivityLabel[,2])
  
  # Split ActivityString by '_'
  ActivityString_Split <- strsplit(ActivityString, "\\_")
  
  # Capitalize first letter for each word in ActivityString_Split 
  ActivityString_CapWord <- sapply(ActivityString_Split, function(x) paste0(toupper(substring(x,1,1)),tolower(substring(x,2))))
  
  # Concatenate strings to make it title (mixed) case
  ActivityString_CapLeading <- sapply(ActivityString_CapWord, function(x) paste(x[1],if(!is.na(x[2]))x[2]))
  
  # Get rid of spaces in the strings
  ActivityString <- sub("\\ $","",ActivityString_CapLeading)
  
  # Replace activity code with activity label in DF_ProcessedTidy_Wide
  DF_ProcessedTidy_Wide$Activity <- factor(DF_ProcessedTidy_Wide$Activity,labels = ActivityString) 
  
  ## Step 6. Make feature names more descriptive
  ## Fix 'BodyBody' string problem, replace leading 't' & 'f' chars with 'Time' & 'Frequency', 
  ## Make 'mean' & 'std' look bold with upper case.
  
  # Gather all pattern string, assign to a vector
  PatternString <- c("(Body){2}","^t","^f","mean","std")
  
  # Gather all replacement string, assign to a vector
  ReplaceString <- c("Body","Time","Frequency","MEAN","STD")
  
  # Take column names from DF_ProcessedTidy_Wide, assign to TargetString
  TargetString <- names(DF_ProcessedTidy_Wide)
  
  # Run a loop to complete multiple sub() functions
  for (i in seq_along(PatternString)) {
    TargetString <- sub(PatternString[i],ReplaceString[i],TargetString)
  }
  
  # Eliminate illegal characters "-" and "()" from variable names
  VarNames <- gsub("-|\\(\\)","",TargetString)
  
  # Assign descriptive variable names to DF_RAW
  names(DF_ProcessedTidy_Wide) <- VarNames
  
  # Create a tidy dataset in narrow format (3240x4 this is just for my learning reference)
  DF_ProcessedTidy_Narrow <- melt(data=DF_ProcessedTidy_Wide, id.vars=c("VolunteerID", "Activity"), measure.vars=names(DF_ProcessedTidy_Wide)[3:20], variable.name = "Siganal", value.name = "ValueMEAN")
  
  ## Step 7. Write data frame as "ProcessedTidyDF_Wide.txt" to your working directory.
  
  # Write processed tidy dataset (wide format) to .txt file and save to your working directory
  write.table(DF_ProcessedTidy_Wide,"./ProcessedTidyDF_Wide.txt",row.name=FALSE)
  
  # Write processed tidy dataset (narrow format) to .txt file and save to your working directory
  write.table(DF_ProcessedTidy_Narrow,"./ProcessedTidyDF_Narrow.txt",row.name=FALSE)
  
  # Display DF_ProcessedTidy_Wide in RStudio
  View(DF_ProcessedTidy_Wide)
  
  # Display DF_ProcessedTidy_Narrow in RStudio
  # View(DF_ProcessedTidy_Narrow)
  
## })
## The line above is a system function to test on runtime performance
## The current runtime is about 8 sec.
## user  system elapsed 
## 7.78    0.14    7.94 

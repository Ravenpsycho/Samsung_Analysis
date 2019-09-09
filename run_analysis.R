## Below is the procedure to merge a train set with a test set of data. Some informations are then
## extracted

## importing the files
my_dat_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = F)
my_dat_train <-  read.table("./UCI HAR Dataset/train/X_train.txt", header = F)
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = F)
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = F)
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = F)
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = F)

## adding activity and subject columns
my_dat_test <- cbind(label_test, subj_test, my_dat_test)
my_dat_train <- cbind(label_train, subj_train, my_dat_train)

## labeling the columns appropriately
legend <- readLines("./UCI HAR Dataset/features.txt")
cleantext <- function(x){
        ret <- strsplit(x," ")[[1]][2]
        return(ret)
}
legend_clean <- sapply(legend, cleantext)
names(my_dat_test) <- c("activity", "subject", legend_clean)
names(my_dat_train) <- c("activity", "subject", legend_clean)

## merging both df into one
complete_set <- rbind(my_dat_test, my_dat_train)
summary(complete_set[,1:4])

## subsetting means and std columns (keeping column 1 & 2 "activity" & subject)
interest <- grep("mean[(][)]|std[(][)]", names(complete_set))
subset_mean_std <- complete_set[,c(1,2,interest)]

## factor activities and subjects then rename activities levels
subset_mean_std$activity <- as.factor(subset_mean_std$activity)
subset_mean_std$subject <- as.factor(subset_mean_std$subject)
legend2 <- readLines("./UCI HAR Dataset/activity_labels.txt")
legend2_clean <- tolower(sapply(legend2, cleantext))
levels(subset_mean_std$activity) <- legend2_clean

## creation of the new dataset (means by subject & activity)
library(dplyr)
new_df <- subset_mean_std %>%
        group_by(subject, activity) %>%
        summarise_all(mean)

## output
if (!file.exists("./output")){
        dir.create("./output")
}
write.table(new_df, file = "./output/means_by_subject_and_activity.txt", row.names = F)

## If you need to read the data again, use argument 'header = TRUE'
## i.e: example_read <- read.table("./output/means_by_subject_and_activity.txt", header = T)

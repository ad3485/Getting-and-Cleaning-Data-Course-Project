# Peer Graded Assignment

featurestxt <- read.table("features.txt", col.names = c("no","featurestxt"))
activitylabels <- read.table("activity_labels.txt", col.names = c("label", "activitylabels"))

subject_test <- read.table("test/subject_test.txt", col.names = "subject")
X_test <- read.table("test/X_test.txt", col.names = featurestxt$features)
Y_test <- read.table("test/Y_test.txt", col.names = "label")
Y_test_label <- left_join(Y_test, activitylabels, by = "label")

tidy_test <- cbind(subject_test, Y_test_label, X_test)
tidy_test <- select(tidy_test, -label)

subject_train <- read.table("train/subject_train.txt", col.names = "subject")
X_train <- read.table("train/X_train.txt", col.names = featurestxt$features)
Y_train <- read.table("train/Y_train.txt", col.names = "label")
Y_train_label <- left_join(Y_train, activitylabels, by = "label")

data_train <- cbind(subject_train, Y_train_label, X_train)
data_train <- select(data_train, -label)

tidy_set <- rbind(tidy_test, data_train)

meanandsd <- select(tidy_set, contains("mean"), contains("sd"))

meanandsd$subject <- as.factor(tidy_set$subject)
meanandsd$activitylabels <- as.factor(tidy_set$activitylabels)

avg <- meanandsd %>%
  group_by(subject, activity) %>%
  summarise_data(funs(mean))

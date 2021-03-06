# Import the data
df <- read.table("datasets/yob2016.txt")
str(df)
# From str function can determine the data is delimited by ;
df <- read.table("datasets/yob2016.txt", sep=";")
str(df)
# Make human readable column names
colnames(df) <- c("firstName", "gender", "amountOfChildren")
# Cast the factor variables to character variables
df$firstName <- as.character(df$firstName)
df$gender <- as.character(df$gender)
#Summary of data
summary(df)
#Structure of Data
str(df)
#Search the end of the string for "yyy"
grep("yyy$", df$firstName)
#Examine the data around that to verify it is a duplicate
df[210:214,]
# Remove duplicate(misspelled) row
y2016 <- df[-c(212),]
# Verify it was removed
y2016[210:214,]


# Import the data
y2015 <- read.table("datasets/yob2015.txt")
str(y2015)
# From str function can determine the data is delimited by ,
y2015 <- read.table("datasets/yob2015.txt", sep=",")
str(y2015)
colnames(y2015) <- c("firstName", "gender", "amountOfChildren")
# Cast the factor variables to character variables
y2015$firstName <- as.character(y2015$firstName)
y2015$gender <- as.character(y2015$gender)
#Summary of data
summary(y2015)
#Structure of Data
str(y2015)
# Display last 10 rows of dataframe
tail(y2015, 10)

final <- merge(y2015, y2016, by = "firstName")

# Remove any rows that did not have names in 2015 and 2016
final <- subset(final, final$amountOfChildren.x >=1 & final$amountOfChildren.y >=1)

# Remove the rows where gender did not match
final <- subset(final, final$gender.y == final$gender.x)

# Remove the duplicate gender column
final$gender.y <- NULL

str(final)
colnames(final) <- c("firstName", "gender", "amountOfChildren2015", "amountOfChildren2016")

# Total the 2015 and 2016 children
final$total = final$amountOfChildren2015 + final$amountOfChildren2016

# Sort in decending order
final <- final[order(-final$total),]

# Top 10 most popular names
head(final, 10)

# Omit boys names
final <- subset(final, final$gender == "F")
head(data.frame(final$firstName, final$total), 10)

write.csv(head(data.frame(final$firstName, final$total), 10), file = "girlsNames.csv", row.names = FALSE)

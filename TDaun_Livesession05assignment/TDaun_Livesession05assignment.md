---
title: "TDaun_Livesession05assignment"
author: "Travis Daun"
date: "12/9/2018"
output: 
  html_document:
    keep_md: true
---


## 1. Data Munging
### a. Import Data

```r
# Import the data
df <- read.table("datasets/yob2016.txt")
str(df)
```

```
## 'data.frame':	32869 obs. of  1 variable:
##  $ V1: Factor w/ 32869 levels "Aaban;M;9","Aabha;F;7",..: 10093 24425 4015 28687 13039 22353 6704 350 10072 12163 ...
```

```r
# From str function can determine the data is delimited by ;
df <- read.table("datasets/yob2016.txt", sep=";")
str(df)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ V1: Factor w/ 30295 levels "Aaban","Aabha",..: 9317 22546 3770 26409 12019 20596 6185 339 9298 11222 ...
##  $ V2: Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ V3: int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```

```r
# Make human readable column names
colnames(df) <- c("firstName", "gender", "amountOfChildren")
# Cast the factor variables to character variables
df$firstName <- as.character(df$firstName)
df$gender <- as.character(df$gender)
```
### b. Display the summary and structure

```r
#Summary of data
summary(df)
```

```
##   firstName            gender          amountOfChildren 
##  Length:32869       Length:32869       Min.   :    5.0  
##  Class :character   Class :character   1st Qu.:    7.0  
##  Mode  :character   Mode  :character   Median :   12.0  
##                                        Mean   :  110.7  
##                                        3rd Qu.:   30.0  
##                                        Max.   :19414.0
```

```r
#Structure of Data
str(df)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ firstName       : chr  "Emma" "Olivia" "Ava" "Sophia" ...
##  $ gender          : chr  "F" "F" "F" "F" ...
##  $ amountOfChildren: int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```
### c. Figure out which name has yyy

```r
#Search the end of the string for "yyy"
grep("yyy$", df$firstName)
```

```
## [1] 212
```

```r
#Examine the data around that to verify it is a duplicate
df[210:214,]
```

```
##     firstName gender amountOfChildren
## 210      Lila      F             1549
## 211     Fiona      F             1547
## 212  Fionayyy      F             1547
## 213    Callie      F             1531
## 214     Lucia      F             1511
```
### d. Remove this particular observation and save as y2016

```r
# Remove duplicate(misspelled) row
y2016 <- df[-c(212),]
# Verify it was removed
y2016[210:214,]
```

```
##     firstName gender amountOfChildren
## 210      Lila      F             1549
## 211     Fiona      F             1547
## 213    Callie      F             1531
## 214     Lucia      F             1511
## 215    Angela      F             1503
```

## 2. Data Merging
### a. Import 2015 data

```r
# Import the data
y2015 <- read.table("datasets/yob2015.txt")
str(y2015)
```

```
## 'data.frame':	33063 obs. of  1 variable:
##  $ V1: Factor w/ 33063 levels "Aaban,M,15","Aabha,F,7",..: 10224 24702 28907 3996 13165 22646 355 10202 6750 12320 ...
```

```r
# From str function can determine the data is delimited by ,
y2015 <- read.table("datasets/yob2015.txt", sep=",")
str(y2015)
```

```
## 'data.frame':	33063 obs. of  3 variables:
##  $ V1: Factor w/ 30553 levels "Aaban","Aabha",..: 9474 22858 26680 3771 12170 20927 344 9453 6252 11404 ...
##  $ V2: Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ V3: int  20415 19638 17381 16340 15574 14871 12371 11766 11381 10283 ...
```

```r
colnames(y2015) <- c("firstName", "gender", "amountOfChildren")
# Cast the factor variables to character variables
y2015$firstName <- as.character(y2015$firstName)
y2015$gender <- as.character(y2015$gender)
#Summary of data
summary(y2015)
```

```
##   firstName            gender          amountOfChildren 
##  Length:33063       Length:33063       Min.   :    5.0  
##  Class :character   Class :character   1st Qu.:    7.0  
##  Mode  :character   Mode  :character   Median :   11.0  
##                                        Mean   :  111.4  
##                                        3rd Qu.:   30.0  
##                                        Max.   :20415.0
```

```r
#Structure of Data
str(y2015)
```

```
## 'data.frame':	33063 obs. of  3 variables:
##  $ firstName       : chr  "Emma" "Olivia" "Sophia" "Ava" ...
##  $ gender          : chr  "F" "F" "F" "F" ...
##  $ amountOfChildren: int  20415 19638 17381 16340 15574 14871 12371 11766 11381 10283 ...
```
### b. Display the last ten rows in the dataframe. Describe something you find interesting about these 10 rows.
* Zyrus and Zyus could be the same name with a misspelling. Could be be duplication of data.

```r
# Display last 10 rows of dataframe
tail(y2015, 10)
```

```
##       firstName gender amountOfChildren
## 33054      Ziyu      M                5
## 33055      Zoel      M                5
## 33056     Zohar      M                5
## 33057    Zolton      M                5
## 33058      Zyah      M                5
## 33059    Zykell      M                5
## 33060    Zyking      M                5
## 33061     Zykir      M                5
## 33062     Zyrus      M                5
## 33063      Zyus      M                5
```
### c. Merge y2016 and y2015 by your Name column; assign it to final.

```r
final <- merge(y2015, y2016, by = "firstName")

# Remove any rows that did not have names in 2015 and 2016
final <- subset(final, final$amountOfChildren.x >=1 & final$amountOfChildren.y >=1)

# Remove the rows where gender did not match
final <- subset(final, final$gender.y == final$gender.x)

# Remove the duplicate gender column
final$gender.y <- NULL

str(final)
```

```
## 'data.frame':	26550 obs. of  4 variables:
##  $ firstName         : chr  "Aaban" "Aabha" "Aabriella" "Aadam" ...
##  $ gender.x          : chr  "M" "F" "F" "M" ...
##  $ amountOfChildren.x: int  15 7 5 22 15 297 31 5 11 8 ...
##  $ amountOfChildren.y: int  9 7 11 18 11 194 28 6 5 14 ...
```

```r
colnames(final) <- c("firstName", "gender", "amountOfChildren2015", "amountOfChildren2016")
```

## 3. Data Summary
### a. Total 2015 and 2016 number of children with the same name.

```r
# Total the 2015 and 2016 children
final$total = final$amountOfChildren2015 + final$amountOfChildren2016
```

### b. Sort the data by Total. What are the top 10 most popular names?

```r
# Sort in decending order
final <- final[order(-final$total),]
# Top 10 most popular names
head(final, 10)
```

```
##       firstName gender amountOfChildren2015 amountOfChildren2016 total
## 9820       Emma      F                20415                19414 39829
## 23607    Olivia      F                19638                19246 38884
## 23258      Noah      M                19594                19015 38609
## 19277      Liam      M                18330                18138 36468
## 27782    Sophia      F                17381                16070 33451
## 3725        Ava      F                16340                16237 32577
## 21102     Mason      M                16591                15192 31783
## 30128   William      M                15863                15668 31531
## 13054     Jacob      M                15914                14416 30330
## 12698  Isabella      F                15574                14722 30296
```
### c. Omit boys and give the top 10 most popular girl’s names.

```r
# Omit boys names
final <- subset(final, final$gender == "F")
head(data.frame(final$firstName, final$total), 10)
```

```
##    final.firstName final.total
## 1             Emma       39829
## 2           Olivia       38884
## 3           Sophia       33451
## 4              Ava       32577
## 5         Isabella       30296
## 6              Mia       29237
## 7        Charlotte       24411
## 8          Abigail       24070
## 9            Emily       22692
## 10          Harper       21016
```
### d. Write these top 10 girl names and their Totals to a CSV file

```r
write.csv(head(data.frame(final$firstName, final$total), 10), file = "girlsNames.csv", row.names = FALSE)
```

## 4. Upload to GitHub
### https://github.com/dauntr/SMU_MSDS_Homework

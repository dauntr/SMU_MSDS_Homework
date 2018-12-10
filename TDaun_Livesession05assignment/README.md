Codebook for TDaun_Livesession05assignment

Files:
TDaun_Livesession05assignment.R
Contains R script for the assignment

TDaun_Livesession05assignment.Rmd
Contains Rmarkdown for the assignment

TDaun_Livesession05assignment.Rproj
R project file

girlsNames.csv
output file of the top 10 girls names for 2015 and 2016 combined.

TDaun_Livesession05assignment.html
To view http://htmlpreview.github.io/?https://github.com/dauntr/SMU_MSDS_Homework/blob/master/TDaun_Livesession05assignment/TDaun_Livesession05assignment.html
/datasets
yob2016.txt
; delimited file consisting of three columns with a first name, a gender, and
the amount of children given that name in 2016.

yob2015.txt
comma separated file consisting of three columns with a first name, a gender,
and the amount of children given that name in 2016.

Objects(in R and Rmd files)
dataframes

df: dataframe manipulations to type cast names and gender into characters.

y2016: dataframe of tidy 2016 data with the duplicate row (212) of "Fionayyy"
removed.

y2015: dataframe of tidy 2015 data.

final: dataframe of merged data between 2015 and 2016. Removed the rows that
duplicated based on opposite genders from 2015 and 2016. Totaled the amount of
children given that name in 2015 and 2016. Sorted in descending order.

## Päivimaria Mäkelä
## 4.11.2023
## Assignment 2 R script

## 2

# import data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#dimensions of the data
dim(lrn14)
# The data frame has 183 rows and 60 colums.
#structure of the data
str(lrn14)
# There are 183 obs. of  60 variables in the data frame. One variable is character and the rest are integers.

## 3

# combine and scale

## attitude
summary(lrn14$Attitude)
# scale attitude to the oiginal scale
lrn14$attitude <- lrn14$Attitude / 10
#check
summary(lrn14$attitude)

## deep, surface and strategic learning

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# dplyr library
#library(dplyr)

### deep
# select the columns 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)
#check
summary(lrn14$deep)

### surface
# select the columns 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)
#check
summary(lrn14$surf)

### strategic
# select the columns 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)
#check
summary(lrn14$stra)

# Create an analysis dataset with the variables
# gender, age, attitude, deep, stra, surf and points

## access the dplyr library
#library(dplyr)
# choose columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))
# see the structure of the new dataset
str(learning2014)

## Column names
# print out the column names of the data
colnames(learning2014)
# change columnames
colnames(learning2014)[c(2,7)] <- c("age", "points")
# print out the new column names of the data
colnames(learning2014)

##Exclude observations where the exam points variable is zero.
# access the dplyr library
#library(dplyr)
summary(learning2014$points)
# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0) 
# check
summary(learning2014$points)
str(learning2014)
#The data has now 166 observations and 7 variables.

#Set the working directory of your R session to the IODS Project folder
# (study how to do this with RStudio). Save the analysis dataset to the ‘data’ folder,
#using for example write_csv() function (readr package, part of tidyverse).
#(Use `str()` and `head()` to make sure that the structure of the data is correct).
setwd("C:/Users/Omistaja/Desktop/Opinnot/IODS/IODS-project/data")
library(tidyverse)
write_csv(learning2014, "learning2014.csv")

#check
check <- read_csv("C:/Users/Omistaja/Desktop/Opinnot/IODS/IODS-project/data/learning2014.csv")
head(learning2014)
head(check)
# datasets seem similiar.

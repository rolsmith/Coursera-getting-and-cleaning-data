##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Week     ####
####           3(1) > Roland Smith > 6 Jul 2021            ####
#                                                          #
##%######################################################%##

# Subsetting and Sorting ----

# Subsetting - quick review ----

### creating an example data frame

set.seed(13435)

X <- data.frame("var1"=sample(1:5),
                "var2"=sample(6:10),
                "var3"=sample(11:15))

### scrambling variables; make some values missing

X <-X[sample(1:5),]; X$var2[c(1,3)] = NA
X

### subset by a column

X[,1]
X[,"var1"]

### subset by row and column

X[1:2, "var2"]

## Logicals ANDS and ORS ----

### rows where Var1 greater equal than 3
### AND where Var3 greater than 11

X[(X$var1<=3 & X$var3 > 11),]

### rows where Var1 greater equal than 3
### OR where Var3 greater than 15

X[(X$var1 <=3 | X$var3 > 15),]

### to deal with missing values
### use the 'which' command

X[which(X$var2 > 8),]

## Sorting ----

### 'sort' function tends to ascending

sort(X$var1)

### decreasing=TRUE

sort(X$var1, decreasing=T)

### sort NAs to the end

sort(X$var2, na.last=TRUE)

## Ordering ----

### pass the 'order' command to the rows of a dataframe

X[order(X$var1),]

### with multiple variables

X[order(X$var1, X$var3),]

## Order with plyr ----

install.packages("plyr")
library(plyr)

arrange(X, var1)

arrange(X, desc(var1))

## Adding Rows and Columns ----

### simply specify a new column

X$var4 <- rnorm(5)
X

### using the 'cbind' command

Y <-cbind(X, rnorm(5))
Y

### using the 'rbind' command for rows

# Summarising Data ----

somalia.baseline <- read.csv("/Users/rolsmith/Documents/R-Learning/Coursera/Coursera-getting-and-cleaning-data/data/DTM_SOM_B2_Baseline_Assessment_Round_1_June_2021_public_0.csv")
somalia.baseline

## looking at the dataset
### head or tail, then ask for number of rows
### (6 is the default)

head(somalia.baseline, n=3)
tail(somalia.baseline, n = 3)

### 'summary' command

summary(somalia.baseline)

### 'str' command gives more in depth information

str(somalia.baseline)

## 'quantiles' of quantitative variables

quantile(somalia.baseline$Returnees.between.2015.2018, na.rm=TRUE)

### Make 'table'

table(somalia.baseline$Settlement.Type, useNA="ifany")

### to make a 2D table

table(somalia.baseline$X.region_name,somalia.baseline$Settlement.Type)

## Row and Column sums

colSums(is.na(somalia.baseline))

## Subset data with specific characteristics

somalia.baseline.rural <- somalia.baseline[somalia.baseline$Settlement.Type %in% c("Rural","rural"),]
str(somalia.baseline.rural)
summary(somalia.baseline.rural)

## Cross Tabs

### (using UCBAdmissions data)

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

### using 'xtabs'

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

### size

object.size(somalia.baseline)
print(object.size(somalia.baseline), units="Mb")

# Creating New Variables ----

### Creating sequences
#### by increment

s1 <- seq(1, 10, by=2); s1

#### by length

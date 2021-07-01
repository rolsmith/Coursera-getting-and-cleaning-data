##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Wk 1     ####
####        > Quiz > Roland Smith > 01 July 2021        ####
#                                                          #
##%######################################################%##

## q.1
getwd()

?download.file

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "/Users/rolsmith/Documents/R-Learning/Coursera/Coursera-getting-and-cleaning-data/idahocommunity.csv" )
read.csv("idahocommunity.csv")
idaho <- read.csv("idahocommunity.csv")
head(idaho)
str(idaho)

library(dplyr)
val.mil <- filter(idaho,VAL==24)
val.mil
dim.val.mil <- c(dim(val.mil))
dim.val.mil
dim.val.mil [1]

## q.3

install.packages("openxlsx")
library(openxlsx)
library(dplyr)

list.files("../Coursera-getting-and-cleaning-data")

dat <- read.xlsx("../Coursera-getting-and-cleaning-data/naturalgasaq.xlsx", rows=18:23, cols=7:15)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

## q.4

library(XML)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
BalResto <- xmlTreeParse(sub("s", "", fileUrl3), useInternal=TRUE)
rootNode <- xmlRoot(BalResto)

zip <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zip == 21231)

## q.5
install.packages("XPATH")
library(data.table)

idaho.data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "../Coursera-getting-and-cleaning-data/idahodata.csv")
DT <- fread("../Coursera-getting-and-cleaning-data/idahodata.csv")
DT

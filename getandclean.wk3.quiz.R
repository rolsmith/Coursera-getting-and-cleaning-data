##%######################################################%##
#                                                          #
####     Coursera > Getting and Cleaning Data > WK      ####
####        3 > Quiz > Roland Smith > 13/07/2021        ####
#                                                          #
##%######################################################%##


?which

#q.1

### Downloading file from source
acs.raw <- download.file
("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

### Reading csv
acs <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
View(acs)

### Create a logical vector that identifies
### households on greater than 10 acres
### who sold more than $10,000 worth of agriculture products

agricultureLogical <- acs[which(acs$ACR==3 & acs$AGS==6), ]
agricultureLogical

which(agricultureLogical)

#q.2

library(jpeg)
?download.file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              "~/Documents/R-Learning/Coursera/Coursera-getting-and-cleaning-data/data/pic")
pic <- readJPEG("~/Documents/R-Learning/Coursera/Coursera-getting-and-cleaning-data/data/pic", native=TRUE)

summary(pic)

quantile(pic, probs=seq(0,1,1/10))

#q.3
library(dplyr)
library(tidyverse)

gdp.data <- read.csv(url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"))
gdp.data <- arrange(gdp.data, Gross.domestic.product.2012, X)

View(gdp.data)

gdp.data <- rename(gdp.data, CountryCode = X)
gdp.data$Gross.domestic.product.2012 <- as.numeric(gdp.data$Gross.domestic.product.2012)
View(gdp.data)

gdp.data <- filter(gdp.data, CountryCode != "")
View(gdp.data)

edu.data <- read.csv(url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"))
View(edu.data)

head(gdp.data, n=3)
head(edu.data, n=3)

gdp.edu <- merge(gdp.data, edu.data,x.by="X", y.by="CountryCode", x.all=TRUE, y.all=TRUE)
View(gdp.edu)

gdp.edu <- arrange(gdp.edu, desc(Gross.domestic.product.2012))
View(gdp.edu)

#q.4

gdp.edu.grp <- group_by(gdp.edu, Income.Group)
summarise(gdp.edu.grp)

summarise(gdp.edu.grp, GDP.by.income = mean(Gross.domestic.product.2012, na.rm=TRUE))
(srs.gdp.edu.grp)

#q.5
?quantile
quantile(gdp.edu.grp$Gross.domestic.product.2012, probs = seq(0,1,0.2), na.rm=TRUE)

srs.gdp.edu.qua <- c(summarise(gdp.edu,
          GDP.quantile = quantile(Gross.domestic.product.2012,
                                  probs = seq(0,1,0.2),
                                  na.rm=TRUE)))

srs.gdp.edu.qua

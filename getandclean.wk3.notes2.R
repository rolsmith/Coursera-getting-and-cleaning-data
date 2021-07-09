##%######################################################%##
#                                                          #
####   Coursera > Getting and Cleaning Data > Week 3    ####
####      > Notes (2) > Roland Smith > 6 Jul 2021       ####
#                                                          #
##%######################################################%##

# Managing Data Frames with dplyr - Basic Tools ----

install.packages("dplyr")
library(dplyr)

str(somalia.baseline)

## checking the variable names
names(somalia.baseline)

## using 'select' function
### to identify specific variables

#### (use ':' to select multiple adjoining columns)

head(select(somalia.baseline, Region.Name:Settlement.Type))

#### use '-' to remove columns

head(select(somalia.baseline,-(IDPs.between.2015.2018..HH.:Dis.fac)))
tail(select(somalia.baseline,-(IDPs.between.2015.2018..HH.:Dis.fac)))

##  using 'filter' function
### to subset rows

#### filter by district name 'Xudur'

somalia.xudur <- filter(somalia.baseline, District.Name == "Xudur")

head(somalia.xudur)
tail(somalia.xudur)

#### filter by inflows greater than 0
#### (changing inflows to numeric)

class(somalia.baseline$Total_inflows)
somalia.baseline$Total_inflows <- as.numeric(somalia.baseline$Total_inflows,
                                             na.rm=TRUE)

somalia.inflows <- filter(somalia.baseline, Total_inflows > 0)
head(somalia.inflows)
dim(somalia.inflows)

#### filter by inflows greater than 0 AND rural
#### (using somalia.baseline$urban == FALSE)

names(somalia.baseline)

somalia.inflows.rural <- filter(somalia.baseline,
                                Total_inflows > 0 & urban == FALSE)
head(somalia.inflows.rural)
dim(somalia.inflows.rural)

#### filter for inflows of Households > 0

somalia.idps.HH <- filter(somalia.baseline, IDPs.between.2015.2018..HH. > 0)
summary(somalia.idps.HH)

##  using 'Arrange' function
### to reorder

#### forcing 'Overall Reliability' to factor

class(somalia.baseline$Overall.Reliability)
?class

#### releveling factors: Very Good > Good > No so good

somalia.baseline$Overall.Reliability <- factor(somalia.baseline$Overall.Reliability, 
                                                  levels=c("Very Good", "Good", "No so good"))

levels(somalia.baseline$Overall.Reliability)

#### creating new data frame from 'somalia.baseline'
#### arranged by $Overall.Reliability
#### ("Very good", "Good", "No so good")

som.base.rel <- arrange(somalia.baseline, somalia.baseline$Overall.Reliability)
head(som.base.rel)
tail(som.base.rel)

class(som.base.rel)

##  using 'rename' function

somalia.baseline <- rename(somalia.baseline, District = District.Name,
                           Region = Region.Name)
head(somalia.baseline)

## using 'mutate' function
### difference from mean of 'idps total'

names(somalia.baseline)

summary(somalia.baseline$IDPs..individuals.)
str(somalia.baseline$IDPs..individuals.)

somalia.baseline$IDPs..individuals. <- as.numeric(somalia.baseline$IDPs..individuals.)

somalia.baseline <- mutate(somalia.baseline,
                           IDPs.trend = IDPs..individuals. - 
                             mean(IDPs..individuals., na.rm=TRUE))

class(somalia.baseline$Current.Population)
somalia.baseline$Current.Population <- as.numeric(somalia.baseline$Current.Population)


somalia.baseline <- mutate(somalia.baseline,
                           percentage.IDPs = 100*(IDPs..individuals./Current.Population))

#### arranging table by % IDPs

arrange(somalia.baseline, desc(Residents), desc(percentage.IDPs), desc(IDPs..individuals.), desc(IDPs.trend))

## Using Group by Function

class(somalia.baseline$Region)

somalia.baseline$Region <- as.factor(somalia.baseline$Region)
levels(somalia.baseline$Region)

som.bas.reg <- group_by(somalia.baseline, Region)
summarise(som.bas.reg)

#### Sorting syntax of 'Settlement Type'

class(somalia.baseline$Settlement.Type)
somalia.baseline$Settlement.Type <- as.factor(somalia.baseline$Settlement.Type)
levels(somalia.baseline$x.Settlement.Type)

somalia.baseline <- rename(somalia.baseline, x.Settlement.Type = Settlement.Type)
names(somalia.baseline)

somalia.baseline$Settlement.Type <- ifelse(somalia.baseline$x.Settlement.Type == "Urban"
                                           | somalia.baseline$x.Settlement.Type == "urban",
                                           "urban", (ifelse(
                                             somalia.baseline$x.Settlement.Type == "Rural"
                                             | somalia.baseline$x.Settlement.Type == "rural",
                                             "rural", "site"
                                           )))
class(somalia.baseline$Settlement.Type)
somalia.baseline$Settlement.Type <- as.factor(somalia.baseline$Settlement.Type)

levels(somalia.baseline$Settlement.Type)

#### Group By 'settlement type'


som.set.type <- group_by(somalia.baseline, Settlement.Type)
som.set.type

somalia.baseline$IDPs.during.2019 <- 
  as.numeric(somalia.baseline$IDPs.during.2019, na.rm=TRUE)

class(somalia.baseline$IDPs.during.2019)

summarise(som.set.type, IDPs.during.2019 = max(IDPs.during.2019, na.rm=TRUE))
  
  
      
##%######################################################%##
#                                                          #
####   Coursera > Getting and Cleaning Data > Week 3a   ####
####       > sandbox > Roland Smith > 6 Jul 2021        ####
#                                                          #
##%######################################################%##

# Creating new Variables ----

## Subsetting variables

somalia.baseline <- read.csv("/Users/rolsmith/Documents/R-Learning/Coursera/Coursera-getting-and-cleaning-data/data/DTM_SOM_B2_Baseline_Assessment_Round_1_June_2021_public_0.csv")
summary(somalia.baseline)

somalia.baseline$jillbow <- somalia.baseline$Settlement.Name %in% c("Jilibow Wiinow", "Jilibow Yerow")
table(somalia.baseline$jillbow)

somalia.baseline$urban <- somalia.baseline$Settlement.Type %in% c("Urban", "urban")
table(somalia.baseline$urban)

## Creating Categorical Variables

str(somalia.baseline$Residents)
somalia.baseline$Residents <- as.numeric(somalia.baseline$Residents)

somalia.baseline$ResidentGroups <- cut (somalia.baseline$Residents,
                                        breaks = quantile(somalia.baseline$Residents, na.rm=TRUE))
table(somalia.baseline$ResidentGroups)
table(somalia.baseline$ResidentGroups, somalia.baseline$Region.Name)

## Creating factor variables

somalia.baseline$Dis.fac <- factor(somalia.baseline$District.Name)
somalia.baseline$Dis.fac

class(somalia.baseline$Dis.fac)

# Reshaping Data ----
install.packages("reshape2")
library(reshape2)

## Melt function 

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), 
                measure.vars=c("mpg","hp"))

head(carMelt, n=3)
tail (carMelt, n=3)

## dcast function

cylData <- dcast(carMelt, cyl ~ variable)
cylData

som.reg.data <- som.reg.data <- dcast(som.base.melt, Region.Name ~ variable, mean)
som.reg.data

# Averaging Values ----

## using tapply

somalia.baseline$Residents <- as.numeric(somalia.baseline$Residents, na.rm=TRUE)
?as.numeric

tapply(somalia.baseline$Residents,somalia.baseline$Settlement.Type,sum, na.rm=TRUE)
str(somalia.baseline$Residents)

## using split / lapply

spl.som.res.set <- split(somalia.baseline$Residents,somalia.baseline$Settlement.Type)
spl.som.res.set

count.som.res.set <- lapply(spl.som.res.set,sum, na.rm=TRUE)
count.som.res.set

total.urban <- count.som.res.set$urban + count.som.res.set$Urban
total.urban

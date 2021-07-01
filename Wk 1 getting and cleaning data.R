##%######################################################%##
#                                                          #
####       Coursera > Getting and Cleaning Data >       ####
####         Week 1 Roland Smith > 29 Jun 2021          ####
#                                                          #
##%######################################################%##

# Reading XML ----

library(XML)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <-xmlRoot(doc)

# Trying another example

fileUrl <- "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
scores

# Reading JSON ----

install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/rolsmith/repos")
names(jsonData)
names (jsonData$owner)
jsonData$owner$login

# The data.table package ----

install.packages ("data.table")
library(data.table)

DF=data.frame(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DF,3)
DT= data.table(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DT,3)

tables()

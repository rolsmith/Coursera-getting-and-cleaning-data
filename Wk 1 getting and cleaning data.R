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

# Reading JSON

install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/rolsmith/repos")
names(jsonData)
names (jsonData$owner)
jsonData$owner$login


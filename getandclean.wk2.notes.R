##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Week     ####
####           2 > Roland Smith > 29 Jun 2021           ####
#                                                          #
##%######################################################%##

# Reading from MySQL ----

install.packages("RMySQL")
library(RMySQL)
library(DBI)
install.packages("DBI")

ucscDb <- dbConnect(MySQL(),user="genome",
                    host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);
result

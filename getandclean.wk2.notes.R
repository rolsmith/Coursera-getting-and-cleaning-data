##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Week     ####
####           2 > Roland Smith > 29 Jun 2021           ####
#                                                          #
##%######################################################%##

# Reading from MySQL ----


library(RMySQL)
library(DBI)

ucscDb <- dbConnect(MySQL(),user="genome",
                    host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);
result

## Connecting to hg19 and listing tables

hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

head(allTables)
str(allTables)

allTables[1:5]

#### each table corresponds to its own datatype)

## Get dimensions of a specific table

#### The 'fields' in the database can be thought of as
#### columns in a datatable

dbListFields(hg19, "affyU133Plus2")

#### to find the rows - 

dbGetQuery(hg19, "select count(*) from affyU133Plus2")

## Read from the table

affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## Select a specific subset

query <- dbSendQuery(hg19, "select * from affyU133Plus2
                     where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)

# Reading from HDF5 ----

#### installing BiocManager packages

chooseCRANmirror()
74
install.packages("BiocManager")


if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()
BiocManager::install("rhdf5")
Yes
library(rhdf5)

#### Creating own h5 file to use as an example

created = h5createFile("example.h5")
created

#### Creating h5 groups

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

#### Writing to groups

A= matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5","foo/A")

B=array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"

h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

#### Write a data set

df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
df
?seq
h5write(df, "example.h5","df")
h5ls("example.h5")

#### Reading data

readA <- h5read("example.h5","foo/A")
readA

# Reading from the Web ----

## Using example of Robert Nicholls Google Scholar page

con <- url("https://scholar.google.com/citations?hl=en&user=j_mxhAYAAAAJ")
htmlCode <- readLines(con)
close(con)
htmlCode

#### This will return a long line of unformatted text

#### Alternative to use XML
install.packages("RCurl")
library(RCurl)
library(XML)
library(xml2)

url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- read_html(url)

html <- xmlTreeParse(url, useInternalNodes=T)

xpathSApply(html,"//title",xmlValue)

#### GET from the httr package

library(httr)
html2=GET(url)
html2

content2 <- content (html2, as="text")
content2

parsedHtml <- htmlParse(content2, asText = TRUE)
parsedHtml


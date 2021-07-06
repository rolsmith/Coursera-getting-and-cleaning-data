
##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Week     ####
####          2 > Roland Smith > 07 July 2021           ####
#                                                          #
##%######################################################%##

#q.1 ----

## 1. Open httr package

library(httr)

## 2. Establish OAUTH details

myapp <- oauth_app("github",
                   key = "13b3ddfa4cda63ce6552",
                   secret = "437fed976af342d749bc739acdc3748f126ff9c0",
                   )
myapp

## 3. Get OAuth credentials
github_token <- oauth1.0_token(oauth_endpoints("github"), myapp)
github_token
# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
req
# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

head(gitDF)
names <- c(gitDF[,3])
names
gitDF[name$datasharing,"created_at"]

colnames(gitDF)

gitDF[gitDF$name %in% "datasharing","created_at"]

#q.2 ----

## install 'sqldf' package
install.packages("sqldf")
library(sqldf)

## download acs dataframe

acs <- read.csv(url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"))
acs

str(acs)

## testing potential queries

sqldf("select * from acs")
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")

#q.3 ----

test <- unique(acs$AGEP)
test

sqldf("select distinct AGEP from acs")

#q.4 ----

library(XML)
library(xml2)
library(xlsimple)

info.url <- "http://biostat.jhsph.edu/~jleek/contact.html"
info.url


library(rvest)

info.read <- read_html("http://biostat.jhsph.edu/~jleek/contact.html")
info.read

info.read

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode[10])
answer <- c(nchar(htmlCode[10]), nchar(htmlCode[20]), 
            nchar(htmlCode[30]), nchar(htmlCode[100]))
answer

#q.5 ----
?read.fwf
wid.fix.w <- c(1,9,5,4,4,5,4,4,5,4,4,5,4,4)
fix.w <- read.fwf(url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
                  widths = wid.fix.w, skip=4,
                 col.names = c("na0", "week", "na1","Nin o1+2(SST)","Nin o1+2(SSTA)",
                                "na2","Nin o3(SST)","Nin o3(SSTA)", "na3", "Nino34(SST)",
                                "Nino34(SSTA)", "na4", "Nino4(SST)", "Nino4(SSTA)"))
head(fix.w)

fix.w.clean <- fix.w[,c(2,4,5,7,8,10,11,13,14)]
head(fix.w.clean)
sum(fix.w.clean$Nin.o3.SST.)

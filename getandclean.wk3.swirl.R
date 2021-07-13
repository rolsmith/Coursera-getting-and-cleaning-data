##%######################################################%##
#                                                          #
####    Coursera > Getting and Cleaning Data > Wk 3     ####
####        > Swirl > Roland Smith > 30 Jun 2021        ####
#                                                          #
##%######################################################%##

# Grouping and Chaining with dplyr ----

library(swirl)

ls()
rm(list=ls())
ls()

swirl()
Roland
1
2

library(dplyr)
cran <- tbl_df(mydf)

rm("mydf")
cran
?group_by

by_package <- group_by(cran, package)
by_package

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
submit()
pack_sum
?count

quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)
top_counts

View(top_counts)

top_counts_sorted <- arrange(top_counts, desc(count))

View(top_counts_sorted)

quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)

top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

View()
View(result3)


# Tidying Data with tidyr
3
1
library(tidyr)

students

?gather

gather(students, "sex", "count", -grade)

gather(students, sex, count, -grade)

students2

res <- gather(students2, sex_class, count, -grade)
res
?separate

separate(res, sex_class, c("sex", "class"))

students3

library(readr)

parse_number("class5")

passed
failed

passed <- mutate(passed, status = "passed")
failed <- mutate(failed, status = "failed")

?bind_rows
bind_rows(passed, failed)

sat
reset()
0

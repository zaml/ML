# download data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv" #not available
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv" #not available
download.file(fileUrl1, destfile = "reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "solutions.csv", method = "curl")

# load data
reviews <- read.csv("reviews.csv")
solutions <- read.csv("solutions.csv")
head(reviews, 2)

# merge command
mergeData <- merge(reviews, solutions, by.x = "solution_id", by.y="id", all =  TRUE)

# intersect command
intersect(names(solutions), names(reviews))
mergeData2 <- merge(reviews, solutions, all = TRUE)

# join (faster than merge)
library(plyr)

df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), y = rnorm(10))
join(df1,  df2) # common id

df3 <- data.frame(id = sample(1:10), z = rnorm(10))
join_all(list(df1, df2, df3)) # multiple frames by common id

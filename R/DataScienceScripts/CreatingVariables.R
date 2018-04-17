## CREATING NEW VARIABLES

# download Baltimore restaurant data
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url = fileUrl, destfile = "restaurants.csv", method = "curl")
restData <- read.csv("restaurants.csv")

# Find restaurants in two neighborhoods
# restData$nearMe will be a TRUE/FALSE
restData$nearMe <- restData$neighborhood %in% c("Roland Park","Homeland")

# create binary variable
restData$wrongZipcode <- ifelse(restData$zipCode <0 , TRUE, FALSE)
table(restData$wrongZipcode, restData$zipCode < 0)

# create categorical variable
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups) # table grouped by quantiles...

#install.packages("Hmisc")
library(Hmisc)
restData$zipGroups2 <- cut2(restData$zipCode, g=4) # 4 groups based on quantiles...
table(restData$zipGroups2) 

# create factor variables
restData$zcf <- factor(restData$zipCode)
class(restData$zcf)

# mutate fuction
#install.packages("plyr")
library(plyr)
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

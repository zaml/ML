#install.packages("sqldf")
library(sqldf)

acs <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")


sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")


c <- unique(acs$AGEP)
b <- sqldf("select distinct AGEP from acs")

library(dplyr)

# Verbs
## - select (grab columns)

select(frameName, city:dptp)
select(frameName, -(city:dptp))

## - filter (subsetting conditions)

chic.f <- filter(frameName, colName > 20)

## - arrange (ordering)

chicago <- arrange(dataFrame, date) # ASC
chicago <- arrange(dataFrame, desc(date)) # DESC

## - rename (variable names)

chicago <- rename(dataFrame, pm45 = FirstName, ptr54 = LastName)

## - mutate (add transform columns)

chicago <- mutate(dataFrame, pm25NewCol = pm25 - mean(pm25, na.rm = T))

## - summarize (data frame stats)

chicago <- mutate(dataFrame, pm25NewCol = pm25 - mean(pm25, na.rm = T))
years <- group_by(dataFrame, year)
summarise(years, ... conNames...)

## pipeline operator

chicago <- %>% mutate(month = as.POSIXlt(date)$mon +1) %>% group_by(month) %>% # ... as many operations as needed.


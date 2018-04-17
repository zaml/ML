## RESHAPING DATA

library(reshape2)

# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname","gear","cyl"), measures.vars = c("mpg","hp"))

# dcast function
# displays cyl broken by variables....
cylData <- dcast(carMelt, cyl ~ variable)
cylData <- dcast(carMelt, cyl ~ variable, mean)


# averaging value
# - sum type of spray per type
tapply(InsectSprays$count, InsectSprays$spray, sum)

# split by the different sprays (list for each spray)
spIns <- split(InsectSprays$count, InsectSprays$spray)

# apply a function
sprCount <- lapply(spIns, sum)

# transform into a vector
unlist(sprCount)

library(RMySQL)

# create database connection
ucscDB <- dbConnect(MySQL(), user="genome",
                    host = "genome-mysql.cse.ucsc.edu")

# execute query
result <- dbGetQuery(ucscDB, "show databases;");

# disconnect MySQL
dbDisconnect(ucscDB);


# ---------------------------

# create database connection
hg19 <- dbConnect(MySQL(), user="genome", db = "hg19",
                    host = "genome-mysql.cse.ucsc.edu")
# collect all tables
allTables <- dbListTables(hg19)

# 11107 tables
length(allTables)

# list columns from particular table [affyU133Plus2]
dbListFields(hg19, "affyU133Plus2")

# execute select statement (58463 rows)
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# collect data in dataframe (all table)
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# subsetting
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); # execute sub query
quantile(affyMis$misMatches)
affyMis10 <- fetch(query, n = 10)
dbClearResult(query);

# disconnect MySQL
dbDisconnect(hg19);

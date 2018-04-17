con <- url("http://www.ucenfotec.ac.cr")
html <- readLines(con)
close(con)
html

library(XML)
url <- "http://www.ucenfotec.ac.cr"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//li[@class='nav-item']", xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHTML <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHTML, "//title", xmlValue)

# access website with auth
page <- GET("webiste url", authenticate("username","password"))

# handles
google <- handle("http://www.google.com")
GET(handle = google, path = "/")
GET(handle = google, path = "search")





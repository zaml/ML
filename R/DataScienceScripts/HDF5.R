source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)

# create a file
created <- h5createFile("example.h5")
created

# create groups within a file
created <- h5createGroup("example.h5","foo")
created <- h5createGroup("example.h5","bar")
created <- h5createGroup("example.h5","foo/foobar")

# list directories
h5ls("example.h5")

# storing data into groups in example.h5

A <- matrix(1:10, nr=2, nc=5)
h5write(A, "example.h5", "foo/A")

B = array(seq(0.1,2.0, by=0.1), dim = c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobar/B")

# list directories
h5ls("example.h5")

# Read Data from File
# list directories
h5read("example.h5", "foo/A")

# index = list(1:3, 1) (first 3 rows 1st colum subset)




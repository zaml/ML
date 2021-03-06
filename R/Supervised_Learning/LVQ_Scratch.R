# --------------------------------------------
# LVQ Simple Example from Scratch
# juan.zamora@nerdyne.com
# --------------------------------------------

# Data Loading -------------------------------

data <- read.csv(file="data/data_scratch_1.csv",head=TRUE,sep=",")

# Select Codebook Vectors --------------------

# we will select 2 random vectors from each class (1/0)
x1 <- c(3.582294042,7.792783481,7.939820817,3.393533211)
x2 <- c(0.791637231,2.331273381,2.866990263,4.67917911)
y <- c(0,0,1,1)

# initial codebook vectors
codebook <- data.frame(x1 = x1, x2 = x2, y = y)

# learning rate (0.1 - 0.5)
learningRate <- 0.7
alpha <- learningRate # to be changed...

# calculate Euclidean distance between the training data (p1,p2)
# and each codebook vector in the codebook  (nrow(data)-2)

# Training Codebook Vectors ------------------

maxEpochs <- 1 

for (epoch in 1:maxEpochs) {
  
  for (i in 1:nrow(data)) {

    p1 <- data[i,"x1"]
    p2 <- data[i,"x2"]
    y <-  data[i,"y"]
    
    # create new variable for euclidiean diffs for x1
    codebook$x1e <- (codebook$x1 - p1)^2
    
    # create new variable for euclidiean diffs for x1
    codebook$x2e <- (codebook$x2 - p2)^2
    
    # sum both x1e and x2e in xsum
    codebook$xsum <- (codebook$x1e + codebook$x2e)
    
    # calculate distance as sqrt(data$xsum)
    codebook$distance <- sqrt(codebook$xsum)
    
    # Select the Best Matching Unit (BMU)
    bmu <- codebook[codebook$distance == min(codebook$distance),]
    
    if (y == bmu$y){
      bmu$x1 <- bmu$x1 + (learningRate * (p1 - bmu$x1))
      bmu$x2 <- bmu$x2 + (learningRate * (p2 - bmu$x2))
    } else {
      bmu$x1 <- bmu$x1 - (learningRate * (p1 - bmu$x1))
      bmu$x2 <- bmu$x2 - (learningRate * (p2 - bmu$x2))
    }
    
    # update the BMU with the new values
    codebook[codebook$distance == min(codebook$distance),]$x1 <- bmu$x1
    codebook[codebook$distance == min(codebook$distance),]$x2 <- bmu$x2
    
  }
  
  # learningRate <- alpha * (1 - (epoch / maxEpochs) )
  
}

# display the trained codebook vector
codebook

# Prediction Over Training Set ---------------

prediction <- numeric(nrow(data))

for (i in 1:nrow(data)) {
  
  p1 <- data[i,"x1"]
  p2 <- data[i,"x2"]
  y <-  data[i,"y"]
  
  # create new variable for euclidiean diffs for x1
  codebook$x1e <- (codebook$x1 - p1)^2
  
  # create new variable for euclidiean diffs for x1
  codebook$x2e <- (codebook$x2 - p2)^2
  
  # sum both x1e and x2e in xsum
  codebook$xsum <- (codebook$x1e + codebook$x2e)
  
  # calculate distance as sqrt(data$xsum)
  codebook$distance <- sqrt(codebook$xsum)
  
  # Select the Best Matching Unit (BMU)
  bmu <- codebook[codebook$distance == min(codebook$distance),]
  
  prediction[i] <- bmu$y
  
}

# Prediction Performance ---------------------

p <- prediction - data$y 
acc <- (length(data$y) - sum(p!=0)) / length(data$y)
cat("The LVQ Prediction Accuracy is: ", acc * 100, "%")
  




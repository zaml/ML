# ------------------------------------------------------------------
# Bird Multiclass Classification with Linear Discriminant Analysis
# @juazammo | nerdyne.com | 2016
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# Data Attributes
# Features where defined based on http://merlin.allaboutbirds.org/
# ------------------------------------------------------------------

# Size (Approx Size)
# 1: hummingbird
# 2: in between (1-3)
# 3: Thursh or Robin
# 4: in between (4-5)
# 5: Raven or Crow
# 6: in between (5-7)
# 7: Goose, Vulture

# Location (In Costa Ria)
# 1: San Jose
# 2: Heredia
# 3: Alajuela
# 4: Limon
# 5: Puntarenas
# 6: Cartago
# 7: Guanacaste

# Color (select 3 colors)
# 1: Black
# 2: Gray
# 3: White
# 4: Brown
# 5: Red
# 6: Yellow
# 7: Green
# 8: Blue
# 9: Orange

# Behavior
# 1: Eating in Feeder
# 2: Swimming
# 3: On the Ground
# 4: In a Tree or Bush
# 5: In a Cable or Fence
# 6: in Flight


setwd("~/Desktop/LDA_Puffbirds")

library(MASS)

# ------------------------------------------------------------------
# 1 - Load Data
# ------------------------------------------------------------------
# load birds data
data <- read.csv(file="Puffbirds.csv",head=TRUE,sep=",")
attach(data)

# ------------------------------------------------------------------
# 2 - Convert Categorical Variables into Dummy Variables
# ------------------------------------------------------------------
Size <- factor(Size)
Location <- factor(Location)
Color1 <- factor(Color1)
Color2 <- factor(Color2)
Color3 <- factor(Color3)
Behavior <- factor(Behavior)

# ------------------------------------------------------------------
# 3 - Fit LDA model
# ------------------------------------------------------------------
lda.fit <- lda(Y ~ Size + Location + Color1 + Color2 + Color3 + Behavior, data = data)
# obtain fir summary
lda.fit
# visual analysis of the fit
plot(lda.fit)

# ------------------------------------------------------------------
# 4 - Prediction
# ------------------------------------------------------------------

# This was a Pied Puffbird seen Alajuela, Relatively Small, With Black and White Colors, Seen in a Branch...
bird1 <- with(data, data.frame(Size = 2, Location = 3, Color1 = 1, Color2 = 3, Color3 = 3, Behavior = 4 ))
lda.pred <- predict(lda.fit, bird1)
lda.class <- lda.pred$class
summary(lda.class)
# [1] 2 3 4 5
# [1] 0 0 0 0
# The Bird was classified as Class 1: White-necked Puffbird. Classification was wrong (but close).

# same parameters as with bird 1, but smaller size...
# This was a Pied Puffbird seen Alajuela, Smaller, With Black and White Colors, Seen in a Branch...
bird2 <- with(data, data.frame(Size = 1, Location = 3, Color1 = 1, Color2 = 3, Color3 = 3, Behavior = 4 ))
lda.pred <- predict(lda.fit, bird2)
lda.class <- lda.pred$class
summary(lda.class)
# 1 2 [3] 4 5
# 0 0 [1] 0 0
# The Bird was classified as Class 3: Pied Puffbird. Classification was Correct!

# Bird 3 belongs to White-fronted Nunbird
bird3 <- with(data, data.frame(Size = 3, Location = 3, Color1 = 2, Color2 = 1, Color3 = 5, Behavior = 4 ))
lda.pred <- predict(lda.fit, bird3)
lda.class <- lda.pred$class
summary(lda.class)
# 1 [2] 3 4 5
# 0 [1] 0 0 0
# The Bird was classified as Class 2: White-fronted Nunbird. Classification was Correct!

# Bird 4 belongs to Lanceolated Monklet
bird4 <- with(data, data.frame(Size = 2, Location = 3, Color1 = 4, Color2 = 1, Color3 = 3, Behavior = 4 ))
lda.pred <- predict(lda.fit, bird4)
lda.class <- lda.pred$class
summary(lda.class)
# 1 2 3 [4] 5
# 0 0 0 [1] 0
# The Bird was classified as Class 4: Lanceolated Monklet. Classification was Correct!

# Remember, the bird is the w3rd.

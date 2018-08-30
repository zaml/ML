# --------------------------------------------
# Naive-Bayes Simple Example from Scratch
# juan.zamora@nerdyne.com
# --------------------------------------------

# Data Loading -------------------------------

data <- read.csv(file="data/data_scratch_3.csv",head=TRUE,sep=",")

# Transform Cat vars into dummy vars  --------

# Weather: sunny = 1, rainy = 0
data$WeatherBin[data$Weather == 'sunny'] <- 1
data$WeatherBin[data$Weather == 'rainy'] <- 0

# Car: working = 1, broken = 0
data$CarBin[data$Car == 'working'] <- 1
data$CarBin[data$Car == 'broken'] <- 0

# Class: go-out = 1, stay-home = 0
data$ClassBin[data$Class == 'go-out'] <- 1
data$ClassBin[data$Class == 'stay-home'] <- 0


# Calculate Weather Probabilities ------------
    
# Conditional probabilities are the probability of each input value given each class value
    
    ## Cond Prob # 1 :: P(Weather=sunny|class=go-out) ##
    
    # count(weather = sunny ∧ class = go-out)
    count_sunny_AND_go_out <- table(data$WeatherBin == 1 & data$ClassBin == 1)['TRUE']
    # count(class = go-out)
    count_class_go_out <- table(data$ClassBin == 1)['TRUE'] 
    # Prob Sunny and Going Out
    P_Sunny_GoOut <- count_sunny_AND_go_out / count_class_go_out
    
    ## Cond Prob # 2 :: P(weather = rainy|class = go-out) ##
    
    # count(weather = rainy ∧ class = go-out)
    count_rainy_AND_go_out <- table(data$WeatherBin == 0 & data$ClassBin == 1)['TRUE']
    # Prob Rainy and Going Out
    P_Rainy_GoOut <- count_rainy_AND_go_out / count_class_go_out
    
    ## Cond Prob # 3 :: P(weather = sunny|class = stay-home) ##
    
    # count(weather = sunny ∧ class = stay-home)
    count_sunny_AND_stay_home <- table(data$WeatherBin == 1 & data$ClassBin == 0)['TRUE']
    # count(class = stay-home)
    count_class_stay_home <- table(data$ClassBin == 0)['TRUE'] 
    # Prob Sunny and Stay Home
    P_Sunny_StayHome <- count_sunny_AND_stay_home / count_class_stay_home
    
    ## Cond Prob # 4 :: P(weather = rainy|class = stay-home) ##
    
    # count(weather = rainy ∧ class = stay-home)
    count_rainy_AND_stay_home <- table(data$WeatherBin == 0 & data$ClassBin == 0)['TRUE']
    # Prob Sunny and Stay Home
    P_Rainy_StayHome <- count_rainy_AND_stay_home / count_class_stay_home
    

# Calculate Car Probabilities ----------------
    
    ## Cond Prob # 1 :: P(car = working|class = go-out)##
    
    # count(car = working ∧ class = go-out)
    count_working_AND_go_out <- table(data$CarBin == 1 & data$ClassBin == 1)['TRUE']
    # Prob Car is Working and Going Out
    P_Working_GoOut <- count_working_AND_go_out / count_class_go_out
    
    ## Cond Prob # 2 :: P(car = broken|class = go-out) ##
    
    # count(car = broken ∧ class = go-out)
    count_broken_AND_go_out <- table(data$CarBin == 0 & data$ClassBin == 1)['TRUE']
    # Prob Car is Broken and Going Out
    P_Broken_GoOut <- count_broken_AND_go_out / count_class_go_out
    
    ## Cond Prob # 3 :: P(car = working|class = stay-home) ##
    
    # count(car = working ∧ class = stay-home)
    count_working_AND_stay_home <- table(data$CarBin == 1 & data$ClassBin == 0)['TRUE']
    # Prob Car is working and Stay Home
    P_Working_StayHome <- count_working_AND_stay_home / count_class_stay_home
    
    ## Cond Prob # 4 :: P(car = broken|class = stay-home) ##
    
    # count(car = broken ∧ class = stay-home)
    count_broken_AND_stay_home <- table(data$CarBin == 0 & data$ClassBin == 0)['TRUE']
    # Prob Car is broken and Stay Home
    P_Broken_StayHome <- count_broken_AND_stay_home / count_class_stay_home
    
    
# Make Predictions ----------------------------

  P_Class_Go_Out = count_class_go_out / length(data$ClassBin)
  P_Class_Stay_Home = count_class_stay_home / length(data$ClassBin)
  
# First Row of the DataSet    
# Sample Instance { weather = sunny, car = working }
    
   # go_out <- P(weather = sunny|class = go-out) × P(car = working|class = go-out) × P(class = go-out)
   P_Go_Out <- P_Sunny_GoOut * P_Working_GoOut * P_Class_Go_Out
   
   # stay-home = P(weather = sunny|class = stay-home) × P(car = working|class = stay-home) × P(class = stay-home)
   P_Stay_Home <- P_Sunny_StayHome * P_Working_StayHome * P_Class_Stay_Home
   
   # MAP(h) = max(P(d|h) × P (h))
   P <- max(P_Go_Out, P_Stay_Home)
   
   # The 0.32 prob tells that given { weather = sunny, car = working } the Bayes theorem will predict
   # that the person will likely go out (if the car is working and the day is sunny)
   
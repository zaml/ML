# Based on https://www.statmethods.net/advstats/cart.html 

# predict a type of deformation (kyphosis) after surgery, 
# from age in months (Age), number of vertebrae involved (Number), 
# and the highest vertebrae operated on (Start).

# Classification Tree with rpart
library(rpart)

# check out the dataset
head(kyphosis)

#1 - Grow Tree --------------------------------------------------------------------

# grow tree 
fit <- rpart(Kyphosis ~ Age + Number + Start, method="class", data=kyphosis)

#2 - Examine The Results ----------------------------------------------------------

# display CP table 
printcp(fit)

# plot cross validation results
plotcp(fit)

# summary of tree splits
summary(fit) # detailed summary of splits

# plot tree 
plot(fit, uniform=TRUE, main="Classification Tree for Kyphosis") 
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# Create Visual Tree (Image Export)
post(fit, file = "tree.ps", 
     title = "Classification Tree for Kyphosis")

#3 - Prune the Tree ----------------------------------------------------------

# prune the tree 
pfit<- prune(fit, cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])

# plot the pruned tree 
plot(pfit, uniform=TRUE, 
     main="Pruned Classification Tree for Kyphosis")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)

# Create Visual Tree (Image Export)
post(pfit, file = "ptree.ps", 
     title = "Pruned Classification Tree for Kyphosis")

library("data.table")
library("hydroGOF")
library("mda")
library("ROCR")

data <- read.csv("C:/Projects/Illusions of Set/Set 2/data/data_2_best.csv")
data$answer.keys = as.numeric(data$answer.keys)
data$answer.keys[data$answer.keys == 1] = 0
data$answer.keys[data$answer.keys == 3] = 1
data$answer.keys[data$answer.keys == 2] = -1
data <- data.table(data)
data[, output:= 0]
data[, likelihood:= 0]

new_answers = matrix(0, nrow = nrow(data), ncol = 3)
# contrastive illusion - 1
# no illusion - 2
# assimilative illusion - 3
new_answers[, 1] = data$answer.keys + 2 # теперь просто закодировано как 1 2 3
new_answers[, 2] = data$size
new_answers[, 3] = data$n

myfunction <- function(par, data, predict=F) {
  
  output = matrix(0, nrow = nrow(data), ncol = 3)
  sd = par[1]
  
 # if(sd < 0 || sd > 10) {
 #   return(1e8) # грязный хак, чтобы минимизатор не вылезал за пределы
 # }             # полезно, если будет больше параметров

  for (i in 1:nrow(data)) {
    
    mu = data[i,2]
    sigma = sd/sqrt(data[i,3])

    likelihood = pnorm(0, mu, sigma)
    
    if(likelihood > 0.5){
      likelihood = 1 - likelihood # случай если mu < 0
    }
    
    #Определяем, что будет воспринято
    
    asp = 2 * likelihood
    cop = (1 - asp)
    
    nop = 0.6 # эту часть надо как-то доделать, пожалуй
    
    output[i,] = c(cop * 0.4, nop, asp * 0.4)
    
  }
  
  if(predict) {
    return(output)
  }
  
  cross_entropy = -mean(log(output[, data[,1]]))
  return(cross_entropy)
}

result <- optim(par = c(5), lower = 1e-5, upper = 30, method="Brent", myfunction, data = data_for_regression)
result

pred = myfunction(result$par, new_answers, T)

pred_whole = apply(pred,1,which.max) 
mean(pred_whole == new_answers[,1]) #0.5828571

hist(new_answers[pred[,1] > mean(pred[, 1]), 2], main="Model high prob of contrastive", xlab="size")
hist(new_answers[pred[,1] <= mean(pred[, 1]), 2], main="Model low prob of contrastive", xlab="size")

hist(new_answers[pred[,1] > mean(pred[, 1]), 3], main="Model high prob of contrastive", xlab="num_fixations")
hist(new_answers[pred[,1] <= mean(pred[, 1]), 3], main="Model low prob of contrastive", xlab="num_fixations")


hist(new_answers[pred[,3] > mean(pred[, 3]), 2], main="Model high prob of assimilative", xlab="size")
hist(new_answers[pred[,3] <= mean(pred[, 3]), 2], main="Model low prob of assimilative", xlab="size")

hist(new_answers[pred[,1] > mean(pred[, 1]), 3], main="Model high prob of assimilative", xlab="size")
hist(new_answers[pred[,1] <= mean(pred[, 1]), 3], main="Model low prob of assimilative", xlab="size")


cat("Mean probabilities of different illusions: ", apply(pred, 2, mean))




illusion_subset = new_answers[which(new_answers[, 1] != 2),] # observations with illusion
illusion_subset_pred = pred[which(new_answers[, 1] != 2),] # predictions for this subset

model_predicted_contr = illusion_subset_pred[, 1] > illusion_subset_pred[, 3]
model_predicted_assim = illusion_subset_pred[, 1] < illusion_subset_pred[, 3]
accuracy_contr = mean(model_predicted_contr == (illusion_subset[,1] == 1) & model_predicted_contr == TRUE)
accuracy_assim = mean(model_predicted_contr == (illusion_subset[,1] == 1) & model_predicted_contr == FALSE)

y = illusion_subset[,1]
y[y == 1] = 0
y[y == 3] = 1
preds = illusion_subset_pred[,3]/0.4 # насколько правомерно добавлять 0.3

pred <- prediction(preds, y)
RP.perf <- performance(pred, "prec", "rec")
plot (RP.perf)
# ROC area under the curve
auc.tmp <- performance(pred,"auc")
auc <- as.numeric(auc.tmp@y.values) #0.6505735 or 0.59883 (best data)

perf <- performance(pred, measure = "tpr", x.measure = "fpr") 
plot(perf, col=rainbow(10))

accuracy = mean(model_predicted_contr == (illusion_subset[,1] == 1))
cat("Accuracy (if we drop the middle): ", accuracy)

# Два параметра - добавилась скорость сужения распределения

myfunction2 <- function(par, data, predict=F) {
  
  output = matrix(0, nrow = nrow(data), ncol = 3)
  sd = par[1]
  p = par[2]
  
  # if(sd < 0 || sd > 10) {
  #   return(1e8) # грязный хак, чтобы минимизатор не вылезал за пределы
  # }             # полезно, если будет больше параметров
  
  for (i in 1:nrow(data)) {
    
    mu = data[i,2]
    sigma = sd/(p * sqrt(data[i,3]))
    
    likelihood = pnorm(0, mu, sigma)
    
    if(likelihood > 0.5){
      likelihood = 1 - likelihood # случай если mu < 0
    }
    
    #Определяем, что будет воспринято
    
    asp = 2 * likelihood
    cop = (1 - asp)
    
    nop = 0.6 # эту часть надо как-то доделать, пожалуй
    
    output[i,] = c(cop * 0.4, nop, asp * 0.4)
    
  }
  
  if(predict) {
    return(output)
  }
  
  cross_entropy = -mean(log(output[, data[,1]]))
  return(cross_entropy)
}

result2 <- optim(par = c(5, 0.5), lower = 1e-5, upper = 30, method="L-BFGS-B", myfunction2, data = new_answers)
result2

pred2 = myfunction2(result2$par, new_answers, T)

hist(new_answers[pred2[,1] > mean(pred2[, 1]), 2], main="Model high prob of contrastive", xlab="size")
hist(new_answers[pred2[,1] <= mean(pred2[, 1]), 2], main="Model low prob of contrastive", xlab="size")

hist(new_answers[pred2[,1] > mean(pred2[, 1]), 3], main="Model high prob of contrastive", xlab="num_fixations")
hist(new_answers[pred2[,1] <= mean(pred2[, 1]), 3], main="Model low prob of contrastive", xlab="num_fixations")


hist(new_answers[pred2[,3] > mean(pred2[, 3]), 2], main="Model high prob of assimilative", xlab="size")
hist(new_answers[pred2[,3] <= mean(pred2[, 3]), 2], main="Model low prob of assimilative", xlab="size")

hist(new_answers[pred2[,1] > mean(pred2[, 1]), 3], main="Model high prob of assimilative", xlab="size")
hist(new_answers[pred2[,1] <= mean(pred2[, 1]), 3], main="Model low prob of assimilative", xlab="size")


cat("Mean probabilities of different illusions: ", apply(pred2, 2, mean))




illusion_subset = new_answers[which(new_answers[, 1] != 2),] # observations with illusion
illusion_subset_pred2 = pred2[which(new_answers[, 1] != 2),] # predictions for this subset

model_predicted_contr = illusion_subset_pred2[, 1] > illusion_subset_pred2[, 3]
model_predicted_assim = illusion_subset_pred2[, 1] < illusion_subset_pred2[, 3]

accuracy = mean(model_predicted_contr == (illusion_subset[,1] == 1))
cat("Accuracy (if we drop the middle): ", accuracy)

# Модель: нет иллюзии появляется, когда вероятности равны 

myfunction3 <- function(par, data, predict=F) {
  
  output = matrix(0, nrow = nrow(data), ncol = 3)
  sd = par[1]
  sd2 = par[2]
  p = par[3]
  
  # if(sd < 0 || sd > 10) {
  #   return(1e8) # грязный хак, чтобы минимизатор не вылезал за пределы
  # }             # полезно, если будет больше параметров
  
  for (i in 1:nrow(data)) {
    
    mu = data[i,2]
    sigma = sd/(sqrt(data[i,3]))
    
    likelihood = pnorm(0, mu, sigma)
    
    if(likelihood > 0.5){
      likelihood = 1 - likelihood # случай если mu < 0
    }
    
    #Определяем, что будет воспринято
    
    asp = 2 * likelihood
    cop = (1 - asp)
    
    razn = asp - cop
    nop1 = pnorm(razn, 0, sd2)
    if (nop1 > 0.5) {
      nop1 = 1 - nop1
    }
    nop1 = 2 * nop1
    nop2 = dgeom(data[i,3], p)
    nop = max(c(nop1, nop2))
    
    output[i,] = c(cop, nop, asp)
    
  }
  
  if(predict) {
    return(output)
  }
  
  cross_entropy = -mean(log(output[, data[,1]]))
  return(cross_entropy)
}

result3 <- optim(par = c(1, 0.5, 0.8), myfunction3, data = new_answers)
result3

pred3 = myfunction3(result3$par, new_answers, T)

hist(new_answers[pred3[,1] > mean(pred3[, 1]), 2], main="Model high prob of contrastive", xlab="size")
hist(new_answers[pred3[,1] <= mean(pred3[, 1]), 2], main="Model low prob of contrastive", xlab="size")

hist(new_answers[pred3[,1] > mean(pred3[, 1]), 3], main="Model high prob of contrastive", xlab="num_fixations")
hist(new_answers[pred3[,1] <= mean(pred3[, 1]), 3], main="Model low prob of contrastive", xlab="num_fixations")


hist(new_answers[pred3[,3] > mean(pred3[, 3]), 2], main="Model high prob of assimilative", xlab="size")
hist(new_answers[pred3[,3] <= mean(pred3[, 3]), 2], main="Model low prob of assimilative", xlab="size")

hist(new_answers[pred3[,1] > mean(pred3[, 3]), 3], main="Model high prob of assimilative", xlab="num_fixations")
hist(new_answers[pred3[,1] <= mean(pred3[, 3]), 3], main="Model low prob of assimilative", xlab="num_fixations")


cat("Mean probabilities of different illusions: ", apply(pred3, 2, mean))

illusion_subset = new_answers[which(new_answers[, 1] != 2),] # observations with illusion
illusion_subset_pred3 = pred3[which(new_answers[, 1] != 2),] # predictions for this subset

model_predicted_contr = illusion_subset_pred3[, 1] > illusion_subset_pred3[, 3]

model_predicted_assim = illusion_subset_pred3[, 1] < illusion_subset_pred3[, 3]

accuracy = mean(model_predicted_contr == (illusion_subset[,1] == 1))
accuracy_contr = mean(model_predicted_contr == (illusion_subset[,1] == 1) & model_predicted_contr == TRUE)
accuracy_assim = mean(model_predicted_contr == (illusion_subset[,1] == 1) & model_predicted_contr == FALSE)
cat("Accuracy (if we drop the middle): ", accuracy)

# Точность на всем датасете 

pred3_whole = apply(pred3,1,which.max)
mean(pred3_whole == new_answers[,1])

# Модель с индивидуальными различиями


library("data.table")
library("mda")

data <- read.csv("./MyData.csv")
data$answer.keys[data$answer.keys == 4] = 1
data$answer.keys[data$answer.keys == 2] = 0
data$answer.keys[data$answer.keys == 3] = -1
data <- data.table(data)
data[, output:= 0]
data[, likelihood:= 0]

new_answers = matrix(0, nrow = 624, ncol = 3)
# contrastive illusion 1
# no illusion 2
# assimilative illusion 3
new_answers[, 1] = data$answer.keys + 2 # теперь просто закодировано как 1 2 3
new_answers[, 2] = data$size_in_thresholds
new_answers[, 3] = data$number_of_fixational_trials

myfunction <- function(par, data, predict=F) {
  
  output = matrix(0, nrow = nrow(data), ncol = 3)
  sd = par[1]
  multi = par[2]
  
 # if(sd < 0 || sd > 10) {
 #   return(1e8) # грязный хак чтобы минимизатор не вылезал за пределы
 # }             # полезно, если будет больше параметров

  for (i in 1:nrow(data)) {
    
    mu = data[i,2]
    sigma = sd/sqrt(data[i,3])

    # подразумевается, что mu всегда > 0?
    likelihood = pnorm(0, mu, sigma)
    
    if(likelihood > 0.5){
      likelihood = 1 - likelihood # случай если mu < 0
    }
    
    # добавляю 0.01, потому что при 0 в целевой функции получается -бесконечность, что не дает оптимизироваться
    # Не должно быть такого, что получается 0. pvalue никогда не 0. Ошибка раньше значит
    # скорее всего, mu иногда получалось меньше нуля, из-за шума
    # на будущее - если что-то не работает, не надо замазывать дырку шпаклёвкой )
    # это называется Monkey Patching, и считается очень плохой практикой.
    # если что-то идёт не так - надо обрывать программу с ошибкой, чтобы исправить причину
    # а не симптомы.
    
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

result <- optim(par = c(5), myfunction, data = new_answers)
result

pred = myfunction(result$par, new_answers, T)

hist(new_answers[pred[,1] > mean(pred[, 1]), 2], main="Model high prob of contrastive", xlab="Size of difference in differential thresholds")
hist(new_answers[pred[,1] <= mean(pred[, 1]), 2], main="Model low prob of contrastive", xlab="Size of difference in differential thresholds")

hist(new_answers[pred[,3] > mean(pred[, 3]), 2], main="Model high prob of assim", xlab="Size of difference in differential thresholds")
hist(new_answers[pred[,3] <= mean(pred[, 3]), 2], main="Model low prob of assim", xlab="Size of difference in differential thresholds")

cat("Mean probabilities of different illusions: ", apply(pred, 2, mean))

hist(new_answers[pred[,1] > mean(pred[, 1]), 3], main="Model high prob of contrastive", xlab="Number of fixational trials")
hist(new_answers[pred[,1] <= mean(pred[, 1]), 3], main="Model low prob of contrastive", xlab="Number of fixational trials")

hist(new_answers[pred[,3] > mean(pred[, 3]), 3], main="Model high prob of assimilative", xlab="Number of fixational trials")
hist(new_answers[pred[,3] <= mean(pred[, 3]), 3], main="Model low prob of assimilative", xlab="Number of fixational trials")

library("data.table")
library("hydroGOF")
library("mda")

data <- read.csv("C:/Projects/Coursework/Experiment/MyData.csv")
data$answer.keys[data$answer.keys == 4] = 1
data$answer.keys[data$answer.keys == 2] = 0
data$answer.keys[data$answer.keys == 3] = -1
data <- data.table(data)
data[, output:= 0]
data[, likelihood:= 0]

new_answers = matrix(0, nrow = 624, ncol = 5)
new_answers[data$answer.keys == -1, 1] = 1 # contrastive illusion in first column
new_answers[data$answer.keys == 0, 2] = 1 # no illusion in second column
new_answers[data$answer.keys == 1, 3] = 1 # assimilative illusion in third column
new_answers[, 4] = data$size_in_thresholds
new_answers[, 5] = data$number_of_fixational_trials


myfunction <- function(par, data) {
# воспринимаемый размер = реальная разница + шум
#data[, input:=paste(list(rnorm(number_of_fixational_trials, size_in_thresholds, sd)))]
  output = matrix(0, nrow = 624, ncol = 3)
  sd = par[1]
  multi = par[2]
  cross_entropy = 0
  for (i in 1:nrow(data)) {
    input = rnorm(data[i,5], data[i,4], sd)
    mu = mean(input)
    sigma = sd(input)/abs(multi * sqrt(data[i,5]))
    if (is.na(sigma)) {
      sigma = 0
    }
    likelihood = pnorm(0, mu, sigma)
    nop = 0.6
    # добавляю 0.01, потому что при 0 в целевой функции получается -бесконечность, что не дает оптимизироваться
    asp = 0.01 + 2 * likelihood
    cop = (1 - 2 * likelihood)
    
    if (nop > 1) {
      nop = 1
    }
    if (asp > 1) {
      asp = 1
    }
    
    if (cop > 1) {
      cop = 1
    }
    if (cop < 0) {
      cop = 0.01
    }
    
    output[i,2] = nop
    output[i,3] = asp * 0.4
    output[i,1] = cop * 0.4
    
    # Softmax
    #output[i,2] = exp(nop)/(exp(nop) + exp(asp) + exp(cop))
    #output[i,3] = exp(asp)/(exp(nop) + exp(asp) + exp(cop))
    #output[i,1] = exp(cop)/(exp(nop) + exp(asp) + exp(cop))
    cross_entropy = cross_entropy - (data[i,1] * log(output[i,1]) + data[i,2] * log(output[i,2]) + data[i,3] * log(output[i,3]))
    
  }
  return(-cross_entropy)
}

result <- optim(par = c(0.02, 1.1), myfunction, data = new_answers)
result

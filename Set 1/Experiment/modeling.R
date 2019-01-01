library("rstan")
library("rstanarm")
library("bayesplot")

# Поменять кодировку answer.keys на -1,0,1
data <- read.csv("C:/Projects/Coursework/Experiment/MyData.csv")
data$answer.keys[data$answer.keys == 4] = 1
data$answer.keys[data$answer.keys == 2] = 0
data$answer.keys[data$answer.keys == 3] = 2
data_list <- c(list(N = 624, c = data$number_of_fixational_trials, t = data$size_in_thresholds, s = data$size, a = data$answer.keys))

# Model only with num of fix. trials and one system
fit <- stan(file = "C:/Projects/Coursework/Experiment/model_only_num_trials_1.stan", data = data_list)

traceplot(fit, pars = c("beta"))
summary(fit)
post <- as.array(fit)
dimnames(post)
# effect of beta
mcmc_hist(post, pars = c("beta"))

# Model only with num of fix. trials and two systems ERROR
fit2 <- stan(file = "C:/Projects/Coursework/Experiment/model_only_num_trials_2.stan", data = data_list)

traceplot(fit2, pars = c("beta"))
summary(fit2)
post <- as.array(fit2)
dimnames(post)
# effect of beta
mcmc_hist(post, pars = c("beta"))

# Model only with size difference in thresholds and one system
fit3 <- stan(file = "C:/Projects/Coursework/Experiment/model_only_size_th_1.stan", data = data_list)

traceplot(fit3, pars = c("beta"))
summary(fit3)
post <- as.array(fit3)
dimnames(post)
# effect of beta
mcmc_hist(post, pars = c("beta"))


# Model with size difference in thresholds, num of fix. trials and one system
fit4 <- stan(file = "C:/Projects/Coursework/Experiment/model_num_size_th_1.stan", data = data_list)

traceplot(fit4, pars = c("gamma"))
summary(fit4)
post <- as.array(fit4)
dimnames(post)
# effect of beta
mcmc_hist(post, pars = c("beta"))

library("data.table")
library("ggplot2")
library("lme4")
library("nnet")
library("dplyr")
library("ggthemes")
library("ROCR")

setwd("C:/Projects/Illusions of Set/Set 2/data")
names_norm <- c("AS_Set_2017_12_14_2146.csv", "AVD_Set_2017_12_14_1858.csv", "Dim_Set_2017_12_14_1804.csv", 
           "EU_Set_2017_12_14_2021.csv", "GAS_Set_2017_12_14_2004.csv", "KVA_Set_2017_12_14_1828.csv",
            "ZVV_Set_2017_12_14_1917.csv", "PK_Set_2017_12_14_2134.csv",
           "AK_Set_2017_12_15_1416.csv", "LPL_Set_2017_12_15_1602.csv",
           "DG_Set_2017_12_15_1659.csv", "NG_Set_2017_12_15_1718.csv", "ES_Set_2017_12_15_1826.csv",
           "MS_Set_2017_12_15_1901.csv", "AD_Set_2017_12_15_1917.csv", "RAA_Set_2017_12_15_1946.csv",
           "KAA_Set_2017_12_15_2005.csv", "NV_Set_2017_12_15_2038.csv", "GMV_Set_2017_12_15_2126.csv",
           "AG_Set_2017_12_20_2125.csv", "AA_Set_2017_12_20_2050.csv",
           "VS_Set_2017_12_20_2033.csv", "DC_Set_2017_12_20_2024.csv", "ZEV_Set_2017_12_20_2012.csv",
           "OR_Set_2017_12_20_1953.csv", "DN_Set_2017_12_20_1935.csv", "PISH_Set_2017_12_20_1925.csv",
           "UO_Set_2017_12_20_1722.csv", "AK_Set_2017_12_20_1623.csv",
           "AA_Set_2017_12_21_1949.csv", "ADV_Set_2017_12_21_1925.csv", "AN_Set_2017_12_21_1843.csv",
           "AES_Set_2017_12_21_1807.csv", "PIAs_Set_2017_12_21_1705.csv", "MLAs_Set_2017_12_21_1654.csv", "Not too bad/AFA_Set_2017_12_14_1722k.csv", "Not too bad/IOA_Set_2017_12_14_1607.csv", 
                "Not too bad/IZ_Set_2017_12_14_2123k.csv", "Not too bad/KAR_Set_2017_12_15_1359.csv",
                "Not too bad/LDU_Set_2017_12_15_1838.csv", "Not too bad/MB_Set_2017_12_15_1535.csv", "Not too bad/MM2_Set_2017_12_15_1634.csv",
                "Not too bad/MO_Set_2017_12_14_1943.csv", "Not too bad/MUSs_Set_2017_12_18_1912.csv", "Not too bad/PG_Set_2017_12_18_1700.csv",
                "Not too bad/PZV_Set_2017_12_18_1629.csv", "Not too bad/TPS_Set_2017_12_15_2109.csv", "Not too bad/VR_Set_2017_12_15_1743.csv",
                "Not too bad/SHUKs_Set_2017_12_20_1317.csv", "Not too bad/SND_Set_2017_12_20_2139.csv")
data <- data.table()
for (i in 1:length(names_norm)) {
  a <- read.csv(file = names_norm[i])
  data <- rbind(data,a)
}
data_best <- data[,. (answer.keys, n, size, trials_3.thisRepN, participant, gender, age)]
#data_best$size <- as.factor(data_best$size)
#data_best$number_of_fixational_trials <- as.factor(data_best$number_of_fixational_trials)
data_best <- data_best[!(size=="NA")]
data_best <- data_best[(trials_3.thisRepN==0)]
levels(data_best$size) = c("0.1", "0.2", "0.3", "0.4", "0.5")
data_best$size <- as.double(data_best$size)
data_best$trials_3.thisRepN <- 1
#levels(data_best$answer.keys) = c("No illusion", "Assimilative", "Contrastive")

levels(data_best$participant) <- c(levels(data_best$participant), "AK2", "AA2")
data_best$participant[841:870] <- "AK2"
data_best$participant[871:900] <- "AA2"

data_right <- data_best[(answer.keys == "right")]
data_left <- data_best[(answer.keys == "left")]
data_left_right <- data_best[(answer.keys == "right"|answer.keys == "left")]
data_down <- data_best[(answer.keys == "down")]


ggplot(data_best, aes(x = answer.keys)) + geom_bar() + ylab("Total amount of illusions") + xlab("") + ggtitle("Number of illusions")


ggplot(data_best, aes(x = size, fill = answer.keys)) + geom_bar(stat = "count", position = position_fill()) + ylab("Fraction of the type of illusions") + xlab("Size of difference between the setting stimuli") + ggtitle("Fraction of illusions for different sizes of difference") + labs(fill = "Type of illusion")
ggplot(data_left, aes(x = size)) + geom_bar() +  ylab("Total amount of illusions") + xlab("Size of difference between the setting stimuli") + ggtitle("Number of contrastive illusions and difference in stimuli's sizes")
ggplot(data_right, aes(x = size)) + geom_bar() +  ylab("Total amount of illusions") + xlab("Size of difference between the setting stimuli") + ggtitle("Number of assimilative illusions and difference in stimuli's sizes")

ggplot(data_left, aes(x = n)) + geom_bar() + ylab("Total amount of illusions") + xlab("Number of fixational trials") + ggtitle("Number of contrastive illusions and number of fixational trials")
ggplot(data_right, aes(x = n)) + geom_bar() + ylab("Total amount of illusions") + xlab("Number of fixational trials") + ggtitle("Number of assimilative illusions and number of fixational trials")

ggplot(data_best, aes(x = size, fill = answer.keys)) + geom_density(alpha=0.4) + xlab("Absolute value of differece between setting stimuli (in cm)") + ylab("Estimated density") + ggtitle("Estimated density of distributions") + labs(fill= "Type of illusion")

# LOG REGRESSION
data_for_regression = data_left_right
# undersampling
my_indexes_contr = which(data_for_regression$answer.keys=="left")
sample = sample(my_indexes_contr, sum(data_for_regression$answer.keys=="right"))
my_indexes_assim = which(data_for_regression$answer.keys=="right")
my_indexes = c(my_indexes_assim, sample)
data_for_regression = data_for_regression[my_indexes]

data_for_regression$answer.keys = as.numeric(data_for_regression$answer.keys)
data_for_regression$answer.keys[data_for_regression$answer.keys == 2] = 1
data_for_regression$answer.keys[data_for_regression$answer.keys == 3] = 0

# weights 
W = data_for_regression$answer.keys == 0
trues = sum(W==T)
falses = sum(W==F)
W[W == FALSE] = trues/length(W)
W[W == TRUE] = falses/length(W)

# model
test <- glm(answer.keys ~ size * n, data = data_for_regression) #weights = W)
summary(test)
pred = fitted.values(test)
pred[pred >= 0.5] = 1
pred[pred < 0.5] = 0
accuracy = mean(pred == data_for_regression$answer.keys)
accuracy

# ROC AUC
predl <- prediction(fitted.values(test), data_for_regression$answer.keys)
RP.perf <- performance(predl, "prec", "rec")
plot (RP.perf)
# ROC area under the curve
auc.tmp <- performance(predl,"auc")
auc <- as.numeric(auc.tmp@y.values) #0.652606 or 0.6067145 (best data)

perf <- performance(predl, measure = "tpr", x.measure = "fpr") 
plot(perf, col=rainbow(10))


# OUR MODEL 

data_for_model = data_for_regression
data_for_model$answer.keys = data_for_model$answer.keys + 1
myfunction <- function(par, data, predict=F) {
  
  output = matrix(0, nrow = nrow(data), ncol = 2)
  sd = par[1]
  
  # if(sd < 0 || sd > 10) {
  #   return(1e8) # грязный хак, чтобы минимизатор не вылезал за пределы
  # }             # полезно, если будет больше параметров
  
  for (i in 1:nrow(data)) {
    
    mu = data[[i,3]]
    sigma = sd/sqrt(data[[i,2]])
    
    likelihood = pnorm(0, mu, sigma)
    
    if(likelihood > 0.5){
      likelihood = 1 - likelihood # случай если mu < 0
    }
    
    #Определяем, что будет воспринято
    
    asp = 2 * likelihood
    cop = (1 - asp)
    
    #nop = 0.6 # эту часть надо как-то доделать, пожалуй
    
    output[i,] = c(cop, asp)
    
  }
  
  if(predict) {
    return(output)
  }
  
  cross_entropy = -mean(log(output[, data$answer.keys])) # проверить
  return(cross_entropy)
}

result <- optim(par = c(5), lower = 1e-5, upper = 30, method="Brent", myfunction, data = data_for_model)
result

pred = myfunction(result$par, data_for_model, T)

hist(data_for_model$size[pred[,1] > mean(pred[, 1])], main="Model high prob of contrastive", xlab="size")
hist(data_for_model$size[pred[,1] <= mean(pred[, 1])], main="Model low prob of contrastive", xlab="size")

hist(data_for_model$n[pred[,1] > mean(pred[, 1])], main="Model high prob of contrastive", xlab="num_fixations")
hist(data_for_model$n[pred[,1] <= mean(pred[, 1])], main="Model low prob of contrastive", xlab="num_fixations")


hist(data_for_model$size[pred[,2] > mean(pred[, 2])], main="Model high prob of assimilative", xlab="size")
hist(data_for_model$size[pred[,2] <= mean(pred[, 2])], main="Model low prob of assimilative", xlab="size")

hist(data_for_model$n[pred[,2] > mean(pred[,2])], main="Model high prob of assimilative", xlab="size")
hist(data_for_model$n[pred[,2] <= mean(pred[, 2])], main="Model low prob of assimilative", xlab="size")


cat("Mean probabilities of different illusions: ", apply(pred, 2, mean))


model_predicted_contr = pred[, 1] > pred[, 2]
model_predicted_assim = pred[, 1] < pred[, 2]

#accuracy
accuracy_contr = mean(model_predicted_contr == (data_for_model$answer.keys == 1))
accuracy_assim = mean(model_predicted_assim == (data_for_model$answer.keys == 2))

predict <- prediction(pred[,2], as.vector(data_for_regression$answer.keys))
RP.perf <- performance(predict, "prec", "rec")
plot (RP.perf)
# ROC area under the curve
auc.tmp <- performance(predict,"auc")
auc <- as.numeric(auc.tmp@y.values) #0.6505735 or 0.59883 (best data)

perf <- performance(predict, measure = "tpr", x.measure = "fpr") 
plot(perf, col=rainbow(10))


# MIXED-EFFECTS LOGISTIC REGRESSION
m <- glmer(answer.keys ~ size * n + (1|participant), data = data_for_regression, family = "binomial")
summary(m)
pred2 = fitted.values(m)
pred2[pred2 >= 0.5] = 1
pred2[pred2 < 0.5] = 0
accuracy = mean(pred2 == data_for_regression$answer.keys)
accuracy


# LOOP

accuracies_lr = c()
aucs_lr = c()
accuracies_m = c()
aucs_m = c()

accuracies_lr_train = c()
aucs_lr_train = c()
accuracies_m_train = c()
aucs_m_train = c()

parameters = c()


for (k in 1:50) {
  
  # LOG REGRESSION
  data_for_regression = data_left_right
  # undersampling
  indexes_contr = which(data_for_regression$answer.keys=="left")
  indexes_assim = which(data_for_regression$answer.keys=="right")
  sample_contr = sample(indexes_contr, sum(data_for_regression$answer.keys=="right"))
  my_indexes = c(indexes_assim, sample_contr)
  data_for_regression = data_for_regression[my_indexes]
  
  # train test data 
  indexes_assim = which(data_for_regression$answer.keys=="right")
  indexes_contr = which(data_for_regression$answer.keys=="left")
  indexes_assim_train = sample(indexes_assim, 104)
  indexes_contr_train = sample(indexes_contr, 104)
  my_indexes_train = c(indexes_assim_train, indexes_contr_train)
  
  data_for_regression$answer.keys = as.numeric(data_for_regression$answer.keys)
  data_for_regression$answer.keys[data_for_regression$answer.keys == 2] = 1
  data_for_regression$answer.keys[data_for_regression$answer.keys == 3] = 0
  
  data_for_regression_train = data_for_regression[my_indexes_train]
  data_for_regression_test = data_for_regression[-my_indexes_train]
  
  # lr model
  lr <- glm(answer.keys ~ size * n, data = data_for_regression_train) #weights = W)
  
  # train accuracy
  pred_train_lr = fitted.values(lr)
  pred_train_lr[pred_train_lr >= 0.5] = 1
  pred_train_lr[pred_train_lr < 0.5] = 0
  accuracy = mean(pred_train_lr == data_for_regression_train$answer.keys)
  accuracies_lr_train = c(accuracies_lr_train, accuracy)
  
  # train ROC AUC
  predl_train <- prediction(fitted.values(lr), data_for_regression_train$answer.keys)
  # ROC area under the curve
  auc.tmp <- performance(predl_train,"auc")
  auc_lr_train <- as.numeric(auc.tmp@y.values) #0.652606 or 0.6067145 (best data)
  aucs_lr_train = c(aucs_lr_train, auc_lr_train)
  
  
  pred = predict(lr, newdata = data_for_regression_test)
  pred[pred >= 0.5] = 1
  pred[pred < 0.5] = 0
  accuracy_lr = mean(pred == data_for_regression_test$answer.keys)
  accuracies_lr = c(accuracies_lr, accuracy_lr)
  
  # ROC AUC
  pred = predict(lr, newdata = data_for_regression_test)
  predl <- prediction(pred, data_for_regression_test$answer.keys)
  # ROC area under the curve
  auc.tmp <- performance(predl,"auc")
  auc_lr <- as.numeric(auc.tmp@y.values) #0.652606 or 0.6067145 (best data)
  aucs_lr = c(aucs_lr, auc_lr)
  
  # OUR MODEL 
  
  data_for_model_train = data_for_regression_train
  data_for_model_test = data_for_regression_test
  data_for_model_train$answer.keys = data_for_model_train$answer.keys + 1
  data_for_model_test$answer.keys = data_for_model_test$answer.keys + 1
  result <- optim(par = c(5), lower = 1e-5, upper = 30, method="Brent", myfunction, data = data_for_model_train)
  
  parameters = c(parameters, result$par)
  # train accuracy
  pred_train_m = myfunction(result$par, data_for_model_train, T)
  model_predicted_contr = pred_train_m[, 1] > pred_train_m[, 2]
  model_predicted_assim = pred_train_m[, 1] < pred_train_m[, 2]

  accuracy_contr_train = mean(model_predicted_contr == (data_for_model_train$answer.keys == 1))
  accuracies_m_train = c(accuracies_m_train, accuracy_contr_train)
  
  # train ROC AUC
  #predl_train_m = myfunction(result$par, data_for_model_train, T)
  #prediction_train_m <- prediction(predl_train_m[,2], as.vector(data_for_model_train$answer.keys))
  # ROC area under the curve
  #auc.tmp <- performance(prediction_train_m[,2],"auc")
  #auc_m_train <- as.numeric(auc.tmp@y.values)
  #aucs_lr = c(aucs_m_train, auc_m_train)
  
  pred = myfunction(result$par, data_for_model_test, T)
  
  model_predicted_contr = pred[, 1] > pred[, 2]
  model_predicted_assim = pred[, 1] < pred[, 2]
  
  #accuracy
  accuracy_contr = mean(model_predicted_contr == (data_for_model_test$answer.keys == 1))
  accuracies_m = c(accuracies_m, accuracy_contr)
  
  pred = myfunction(result$par, data_for_model_test, T)
  predict <- prediction(pred[,2], as.vector(data_for_model_test$answer.keys))
  # ROC area under the curve
  auc.tmp <- performance(predict,"auc")
  auc_m <- as.numeric(auc.tmp@y.values)
  aucs_m = c(aucs_m, auc_m)
}


cat("Mean accuracy of lr:", mean(accuracies_lr_train))
cat("Mean accuracy of model:", mean(accuracies_m_train))
cat("Mean auc of lr:", mean(aucs_lr_train))
cat("Mean auc of model:", mean(aucs_m_train))


cat("Mean accuracy of lr:", mean(accuracies_lr))
cat("Mean accuracy of model:", mean(accuracies_m))
cat("Mean auc of lr:", mean(aucs_lr))
cat("Mean auc of model:", mean(aucs_m))




subject_sums <- group_by(data_best, size, participant) %>%
  summarize(sa = sum(answer.keys == "right"), sc = sum(answer.keys == "left"), sn = sum(answer.keys == "down"))

subject_sums2 <- group_by(data_best, answer.keys, participant) %>%
  summarize(s = sum(trials_3.thisRepN))

subject_sums3 <- group_by(data_best, size, answer.keys, participant) %>%
  summarize(s = sum(trials_3.thisRepN))

ggplot(subject_sums2, aes(x = answer.keys, y = s)) +
  stat_summary(
    geom = "bar",
    fun.y = "mean",
    col = "black",
    fill = "gray70"
  ) +
  geom_point(position = position_jitter(h = 0, w = 0.1))

ggplot(subject_sums3, aes(x = size, y = s, col = answer.keys)) +
  stat_summary(
    geom = "bar",
    fun.y = "mean",
    col = "black",
    fill = "gray70"
  ) +
  geom_point(position = position_jitter(h = 0.2, w = 0.2))

ggplot(data_best, aes(x = size, y = n, col = answer.keys)) +
  geom_point(position = position_jitter(h = 0.2, w = 0.2))

subject_means <- group_by(data_best, participant, answer.keys) %>%
  summarize(s = mean(size), n = mean(n), sd = sd(size), sum = sum(trials_3.thisRepN)) 

# %>%
#  filter(!is.na(sd)) #удалила единожды проявившиеся иллюзии

# DIFFERENCES

subject_means_n <- group_by(data_best, participant) %>%
  filter(answer.keys == "down") %>%
  summarize(sn = mean(size), nn = mean(n), sumn = sum(trials_3.thisRepN))

subject_means_a <- group_by(data_best, participant) %>%
  filter(answer.keys == "right") %>%
  summarize(sa = mean(size), na = mean(n), suma = sum(trials_3.thisRepN))

subject_means_c <- group_by(data_best, participant) %>%
  filter(answer.keys == "left") %>%
  summarize(sc = mean(size), nc = mean(n), sumc = sum(trials_3.thisRepN))

m <- merge(subject_means_n, subject_means_a, by = "participant",
      all = TRUE)

m <- merge(m, subject_means_c, by = "participant",
           all = TRUE)

m$size_contrastive_no_illusion = m$sc - m$sn
m$size_assimilative_no_illusion  = m$sa - m$sn
m$size_contrastive_assimilative  = m$sc - m$sa

m$n_contrastive_no_illusion = m$nc - m$nn
m$n_assimilative_no_illusion = m$na - m$nn
m$n_contrastive_assimilative = m$nc - m$na

m$div_contrastive_no_illusion = m$sumc/m$sumn
m$div_assimilative_no_illusion = m$suma/m$sumn
m$div_assimilative_contrastive = m$suma/m$sumc

ggplot(m, aes(x = "size_contrastive_no_illusion", y = size_contrastive_no_illusion, size = div_contrastive_no_illusion)) + geom_boxplot() +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("") +
  ylab("") + geom_boxplot(aes(x = "size_assimilative_no_illusion", y = size_assimilative_no_illusion, size = div_assimilative_no_illusion)) + 
  geom_point(aes(x = "size_assimilative_no_illusion", y = size_assimilative_no_illusion), position = position_jitter(h = 0, w = 0.2)) +
  geom_boxplot(aes(x = "size_contrastive_assimilative", y = size_contrastive_assimilative, size = div_assimilative_contrastive)) + 
  geom_point(aes(x = "size_contrastive_assimilative", y = size_contrastive_assimilative), position = position_jitter(h = 0, w = 0.2))


ggplot(m, aes(x = "n_contrastive_no_illusion", y = n_contrastive_no_illusion, size = div_contrastive_no_illusion)) + geom_boxplot() +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("") +
  ylab("") + geom_boxplot(aes(x = "n_assimilative_no_illusion", y = n_assimilative_no_illusion, size = div_assimilative_no_illusion)) + 
  geom_point(aes(x = "n_assimilative_no_illusion", y = n_assimilative_no_illusion), position = position_jitter(h = 0, w = 0.2)) +
  geom_boxplot(aes(x = "n_contrastive_assimilative", y = n_contrastive_assimilative, size = div_assimilative_contrastive)) + 
  geom_point(aes(x = "n_contrastive_assimilative", y = n_contrastive_assimilative), position = position_jitter(h = 0, w = 0.2))



ggplot(subject_means, aes(x = answer.keys, y = s, size = sum)) +
  stat_summary(
    geom = "bar",
    fun.y = "mean",
    col = "black",
    fill = "gray70"
  ) +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("Type of illusion") +
  ylab("Size of difference (in mm)")


ggplot(subject_means, aes(x = answer.keys, y = s, size = sum)) + geom_boxplot() +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("Type of illusion") +
  ylab("Size of difference (in mm)")


ggplot(subject_means, aes(x = answer.keys, y = n, size = sum)) +
  stat_summary(
    geom = "bar",
    fun.y = "mean",
    col = "black",
    fill = "gray70"
  ) +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("Type of illusion") +
  ylab("Number of fixational trials")

ggplot(subject_means, aes(x = answer.keys, y = n, size = sum)) + geom_boxplot() +
  geom_point(position = position_jitter(h = 0, w = 0.2)) + xlab("Type of illusion") +
  ylab("Number of fixational trials")

ggplot(subject_means, aes(x = s, y = n, size = sum)) +
  geom_point() + facet_wrap(~ answer.keys) + xlab("Size of difference (in mm)") +
  ylab("Number of fixational trials") + theme_few()


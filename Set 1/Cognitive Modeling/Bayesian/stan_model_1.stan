data {
	int<lower=1> nY; // количество наблюдений (всего)
	int<lower=1> nS; // количество испытуемых
	int<lower=1,upper=nS> Subj[nY]; // вектор с номерами испытуемых для каждого из наблюдений
	vector[nY] size_diff; // целевой предиктор, разница между стимулами
	vector[nY] num_of_trials; // количество установочных проб, не понадобится в этом анализе
  int<lower = 0, upper = 1> Y[nY]; // результат: какой тип иллюзии наблюдался. 1 - ассимилятивная
}

parameters {
  real<lower = 0> initial_sd_mu;
  real<lower = 0> initial_sd_sd;
  real<lower = 0> initial_sd[nS];
}

model {
  
	// априорные распределения
	initial_sd_mu ~ cauchy(0, 3);
  initial_sd_sd ~ cauchy(0, 3);
  
	// "откуда" (из какого распределения по популяции) генерировались индивидуальные размеры эффекта
  initial_sd ~ normal(initial_sd_mu, initial_sd_sd);

	// генерация наблюдений с учетом общего смещения и индивидуальных эффектов (логистическая регрессия)
	//for(i in 1:nY){
    // Y[i] ~ bernoulli_logit(exp(normal_lpdf(0 | size_diff[i], initial_sd[Subj[i]]/num_of_trials[i])));
	// }
	for(i in 1: nY){
	Y[i] ~ bernoulli_logit(exp(normal_lpdf(0 | size_diff[i], initial_sd[Subj[i]]/num_of_trials[i])));}
}

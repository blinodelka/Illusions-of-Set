data {
	int<lower=1> nY; // количество наблюдений (всего)
	int<lower=1> nS; // количество испытуемых
	int<lower=1,upper=nS> Subj[nY]; // вектор с номерами испытуемых для каждого из наблюдений
	vector[nY] size_diff; // разница между стимулами
	vector[nY] num_of_trials; // количество установочных проб
	int<lower = 0, upper = 1> Y[nY]; // результат: какой тип иллюзии наблюдался. 1 - 		ассимилятивная, 0 - контрастная
}

parameters {
	real intercept_mu; 
	real<lower = 0> intercept_sd;
	real beta_1_mu; 
	real<lower = 0> beta_1_sd;
	real beta_2_mu;
	real<lower = 0> beta_2_sd; 
	vector[nS] intercept;
	vector[nS] beta_1;
	vector[nS] beta_2; 
}

model {
	// априорные распределения
	intercept_mu ~ normal(0,10); 
	intercept_sd ~ cauchy(0,3);
	beta_1_mu ~ normal(0,1);
	beta_1_sd ~ cauchy(0,3);
	beta_2_mu ~ uniform(-5,5); // альтернативная гипотеза: эффект может быть любым между -5 и 5
	beta_2_sd ~ cauchy(0,3);

	// "откуда" (из какого распределения по популяции) генерировались индивидуальные размеры 		эффекта
	intercept ~ normal(intercept_mu, intercept_sd);
	beta_1 ~ normal(beta_1_mu, beta_1_sd);
	beta_2 ~ normal(beta_2_mu, beta_2_sd);

	// генерация наблюдений с учетом смещения и индивидуальных эффектов (логистическая регрессия)
	for(i in 1:nY){
		Y[i] ~ bernoulli_logit(intercept[Subj[i]] + beta_1[Subj[i]]*size_diff[i] + 			beta_2[Subj[i]]*num_of_trials[i]);
	}
}

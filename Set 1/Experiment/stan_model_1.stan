data {
	int<lower=1> nY; # количество наблюдений (всего)
	int<lower=1> nS; # количество испытуемых
	int<lower=1,upper=nS> Subj[nY]; # вектор с номерами испытуемых
	vector[nY] size; 
	vector[nY] num_of_trials; 
  vector[nY] Y; 
}

parameters {
	real intercept_mu; # среднее смещение по всем испытуемым
	real<lower=0> intercept_sd ; # стандартное отклонение (вариация) смещения среди испытуемых
	vector[nS] intercept ; # переменная, чтобы сохранять смещение для каждого из испытуемых
  real beta_1_mu;
  real_beta_1_sd;
  vector[nS] beta_1;
  real beta_2_mu;
  real_beta_2_sd;
  vector[nS] beta_2;
  real beta_3_mu;
  real_beta_3_sd;
  vector[nS] beta_3;
}

model {
	# априорные распределения
	intercept_mu ~ normal(0,10);
  intercept_sd ~ cauchy(0,3);
	beta_1_mu ~ normal(0,1);
  beta_1_sd ~ cauchy(0,3);
	beta_2_mu ~ normal(0,1);
  beta_2_sd ~ cauchy(0,3);
	beta_3_mu ~ normal(0,1);
  beta_3_sd ~ cauchy(0,3);

	# определить, "откуда" (из какого распределения по популяции) генерировались индивидуальные смещения 
	intercept ~ normal(intercept_mu,intercept_sd);
  beta_1 ~ normal(beta_1_mu, beta_1_sd);
  beta_2 ~ normal(beta_2_mu, beta_2_sd);
  beta_3 ~ normal(beta_3_mu, beta_3_sd);

	# генерация наблюдений с учетом индивидуального смещения и условия
	for(i in 1:nY){
		Y[i] ~ bernoulli_logit(intercept[Subj[i]] + beta_1[Subj[i]]*size[i] + beta_2[Subj[i]]*num_of_trials[i] + beta_3[Subj[i]]*size[i]*num_of_trials[i]);
	}
}
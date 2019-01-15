data {
	int<lower=1> nY; // количество наблюдений (всего)
	int<lower=1> nS; // количество испытуемых
	int<lower=1,upper=nS> Subj[nY]; // вектор с номерами испытуемых для каждого из наблюдений
	vector[nY] size_diff; // целевой предиктор, разница между стимулами
	vector[nY] num_of_trials; // количество установочных проб, не понадобится в этом анализе
  int<lower = 0, upper = 1> Y[nY]; // результат: какой тип иллюзии наблюдался. 1 - ассимилятивная
}

parameters {
  real intercept;
  real beta_1;
  real beta_2;
}

model {
  
	// априорные распределения
  intercept ~ cauchy(0,3);
  beta_1 ~ normal(0,1);
  beta_2 ~ normal(0,1);
  
	for(i in 1: nY){
	  Y[i] ~ bernoulli_logit(intercept + beta_1*size_diff[i] + beta_2*num_of_trials[i]);}
}
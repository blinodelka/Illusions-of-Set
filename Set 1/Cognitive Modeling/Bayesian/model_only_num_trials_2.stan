data {
  int<lower = 1> N; // Total number of datapoints
  vector<lower = 0, upper = 26>[N] c; // Number of set stimuli
  vector<lower = 1, upper = 3>[N] t; // Size of stimuli in diff.thresholds
  vector<lower = 0>[N] s; // Absolute size of difference
  vector[N] a; // The type of illusion
}

// Как представить уверенность?
// Модель только с дифф.порогами
parameters {
  real<lower = 0> sigma1;
  real<lower = 0> sigma2;
  real alpha1;
  real beta1;
  real alpha2;
  real beta2;
}
transformed parameters {
  vector[N] mu;
  real sigma;
  mu = alpha1 + c * beta1 + alpha2 + c * beta2;
  sigma = sigma1/2 + sigma2/2;
}
model {
  alpha1 ~ beta(1, 1);
  beta1 ~ beta(1, 1);
  alpha2 ~ beta(1, 1);
  beta2 ~ beta(1, 1);
  sigma1 ~ normal(0, 1);
  sigma2 ~ normal(0, 1);
  a ~ normal(mu, sigma);
}
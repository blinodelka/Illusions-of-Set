data {
  int<lower = 1> N; // Total number of datapoints
  vector<lower = 0, upper = 26>[N] c; // Number of set stimuli
  vector<lower = 1, upper = 3>[N] t; // Size of stimuli in diff.thresholds
  vector<lower = 0>[N] s; // Absolute size of difference
  vector[N] a; // The type of illusion
}

parameters {
  real<lower = 0> sigma;
  real alpha;
  real beta;
}
// should mu be vectors?
transformed parameters {
  vector[N] mu;
  mu = alpha + c * beta;
}
model {
  alpha ~ beta(1, 1);
  beta ~ beta(1, 1);
  sigma ~ normal(0, 1);
  a ~ normal(mu, sigma);
}
generated quantities {
  real average_mu;
  average_mu = mean(mu);
}
data {
  int<lower = 1> N; // Total number of datapoints
  vector<lower = 0, upper = 26>[N] num; // Number of adaptational trials
  vector<lower = 1, upper = 3>[N] dif; // Difference between adaptational stimuli (in differential thresholds)
  vector<lower = 0>[N] abs_dif; // Absolute size of difference
  vector[N] illusion; // The type of illusion
}

parameters {
  real<lower = 0> alpha;
  real<lower = 0> beta;
  real<lover = 0> sigma;
}

transformed parameters {
  vector[N] sigma1;
  sigma1 = 1/(alpha*num);
  vector[N] mu1;
  mu1 = dif;
  vector[N] sigma2;
  // sigma2 = (beta/sigma1) To check
}
model {
  alpha ~ beta(1, 1);
  beta ~ beta(1, 1);
  c1 ~ normal(mu1,sigma1); // Distribution of the typical category
  c2 ~ 1 - normal(mu1,sigma1); // to check (what if < zero)
  // add hierachical for subjects differential threshold (different sigma for every subject)
  for (n in 1:N) {
    
  }


  a ~ normal(mu, sigma);
}
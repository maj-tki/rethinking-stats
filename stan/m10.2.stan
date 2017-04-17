data {
  # number obs
  int n;
  int pulled_left[n];
  vector[n] prosoc_left;
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
}
parameters {
  real a;
  real bp;
}
transformed parameters {
  vector[n] mu;
  mu = a + bp * prosoc_left;
}
model {
  a ~ normal(a_mean, a_scale);
  bp ~ normal(bp_mean, bp_scale);
  pulled_left ~ binomial_logit(1, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(1, inv_logit(mu[i]));
  }
}
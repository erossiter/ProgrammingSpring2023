#include <Rcpp.h>

// [[Rcpp::export]]
double cpp_min(const Rcpp::NumericVector& x) {
  int n = x.size();
  if (n == 0) {
    Rcpp::stop("vector must not be empty");
  }
  double min_val = x[0];
  for (int i = 1; i < n; i++) {
    if (x[i] < min_val) {
      min_val = x[i];
    }
  }
  return min_val;
}
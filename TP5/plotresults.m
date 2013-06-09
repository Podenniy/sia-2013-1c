function t = plotresults(g)

  x = [];
  min_ = [];
  mean_ = [];
  p90 = [];
  p95 = [];
  max_ = [];
  i = 1;
  
  for k = g
    j = k.d;
    min_(i) = j.f_min;
    mean_(i) = j.f_avg;
    p90(i) = j.f_90th;
    p95(i) = j.f_95th;
    max_(i) = j.f_max;
    x(i) = i;
    i = i+1;
  end
  plot(x, min_, x, mean_, x, p90, x, p95, x, max_);
end
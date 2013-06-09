function t=content_limit(ratio)
  t = @(prev, state)(state.f_avg <= prev.f_avg * (1+ratio));
end
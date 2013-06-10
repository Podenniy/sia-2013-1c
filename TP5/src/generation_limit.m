function t=generation_limit(generations)
  t = @(prev, state)(state.g >= generations);
end
function t=structure_limit(difference)
  t = @(prev, state)(are_similar(prev, state, difference));
end
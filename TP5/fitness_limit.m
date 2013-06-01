function t=fitness_limit(target_fitness)
  t = @(prev, state)(state.f_max >= target_fitness);
end
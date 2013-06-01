function i = backpropagate_individual(i)
  g = @tanh;
  gp = @(x)(sech(x).^2);
  params = struct(...
    'eta', 0.3, ...
    'alpha', 0.3, ...
    'noise_factor', 0, ...
    'hard_limit', 40, ...
    'training_set_size', 100, ...
    'adaptative_increment', 0.0001, ...
    'adaptative_decrement', 0.01, ...
    'adaptative_steps', 4, ...
    'debug', false ...
  );
  
  global dataset expected;
  data = learn(dataset, expected, i.W, g, gp, params);
  i.W = data.W;
  i = flatten(i);
end
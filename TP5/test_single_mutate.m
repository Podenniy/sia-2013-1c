function t=test_single_mutate()

  m =load('best_network.mat');
  
  t = struct();
  t.W = m.data.W;
  t = flatten(t);
  t.fitness = fitness(t);
  
  
  t = single_mutate(t, 1, 900);
end
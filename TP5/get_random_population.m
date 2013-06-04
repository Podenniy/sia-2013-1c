function t = get_random_population(N)
  t = [];
  DIMS = [2 9 6 1];
  
  for i=1:N
    e = struct();
    e.W = get_random_w(DIMS, 0.4);
    e = backpropagate_individual(e);
    e = evaluate_individual(e);
    t(i).i = e;
  end
  
  t = struct('p', t, 'N', N, 'g', 1);
end
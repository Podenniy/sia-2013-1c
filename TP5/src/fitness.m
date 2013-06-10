function t = fitness(ind)
  global test_set test_results;
  
  W = ind.W;
  y = zeros(size(test_set, 2), 1);
  for i=1:size(test_set, 2)
     z = run_neural_network(W, test_set(:,i), @tanh);
     y(i) = z.V.(char('@'+(size(fieldnames(z.V), 1))));
  end
  t = 1/mean(abs(y'-test_results))^2;
end
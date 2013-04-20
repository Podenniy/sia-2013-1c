function print_xor_results_for_matrix(W)
  dataset = [1,1,0,0;1,0,1,0];
  expected = [0,1,1,0];
  for i=1:size(dataset,2)
    t = run_neural_network(W, dataset(:,i));
    display([num2str(dataset(1,i))  ' XOR '  num2str(dataset(2,i))  ' = '  num2str(t.V.C)])
  end
end
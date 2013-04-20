function y = get_xor_results(W)

  y = [];
  dataset = [1,1,0,0;1,0,1,0];
  expected = [0,1,1,0];
  for i=1:size(dataset,2)
    t = run_neural_network(W, dataset(:,i));
    y = [y t.V.C];
  end
end
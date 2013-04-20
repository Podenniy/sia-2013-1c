function W=learn(dataset, expected, W, eta)

  levels = size(fieldnames(W), 1);
  flag = 0;
  iter = 1;

  P = [];
  while flag == 0
    flag = 1;
    iter = iter + 1;
    for i=1:size(dataset, 2)

      E = dataset(:,i);
      S = expected(i);
      networkresult = run_neural_network(W, E);
      V = networkresult.V;
      H = networkresult.H;
      W = backpropagation_learning(W, V, H, S, eta);

      P = [P sum(V.(lvl(levels+1))-S)];

      if abs(V.(lvl(levels+1))-S) > 0.1
        flag = 0;
      end

    end
    
    % this can be compared directly with "expected"
    y = get_xor_results(W);
  end
  plot(P);
  display(['Took me ' num2str(iter) ' iterations to reduce error to <0.1'])

end

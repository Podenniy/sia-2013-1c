function W=learn(dataset, expected, W, eta, g, gp, cap)

  NO_VARIATION_ITERATIONS = 3500;
  NO_VARIATION_DIFF = 0.01;

  levels = size(fieldnames(W), 1);
  flag = 0;
  iter = 0;
  last = [];

  P = [];
  while flag == 0
    flag = 1;

    idxs = randperm(size(dataset, 2));
    dataset = dataset(:,idxs);
    expected = expected(idxs);

    for i=1:size(dataset, 2)

      E = dataset(:,i);
      S = expected(i);
      networkresult = run_neural_network(W, E, g);
      V = networkresult.V;
      H = networkresult.H;
      W = backpropagation_learning(W, V, H, S, eta, gp);

      P = [P norm(V.(lvl(levels+1))-S)];

      if norm(V.(lvl(levels+1))-S) > 0.1
        flag = 0;
      end

    end

    if mod(iter, NO_VARIATION_ITERATIONS) == 0
      current = [];
      for i=1:size(dataset, 2)
        networkresult = run_neural_network(W, E, g);
        current = [current networkresult.V.(lvl(levels+1))];
      end
      if ~all(last == 0) && (norm(current - last) < NO_VARIATION_DIFF)
        display('Things didnt change in a while, randomizing');
        matrix_dims = [size(W.(lvl(1)), 2)-1];
        for i=1:levels
          matrix_dims = [matrix_dims size(W.(lvl(i)), 1)];
        end
        W = get_random_w(matrix_dims, cap);
      end
      last = current;
    end

    iter = iter + 1;
  end
  plot(P);
  display(['Took me ' num2str(iter) ' iterations to reduce error to <0.1'])

end

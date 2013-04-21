function W=learn(dataset, expected, W, eta, g, gp, cap, alpha, error_cap)

  NO_VARIATION_ITERATIONS = 3500;
  NO_VARIATION_DIFF = 0.01;

  levels = size(fieldnames(W), 1);
  flag = 0;
  iter = 0;
  last = [];

  mean_error = [];
  deviation = [];
  error = zeros(size(dataset, 2), 1);
  Q = zeros(10000);
  while flag == 0
    flag = 1;

    idxs = randperm(size(dataset, 2));
    dataset = dataset(:,idxs);
    expected = expected(idxs);
    
    previous_changes = {};
    for i = 1 : levels
      name = lvl(i);
      previous_changes.(name) = zeros(size(W.(name)));
    end
    current = zeros(size(expected));
    for i=1:size(dataset, 2)

      E = dataset(:,i);
      S = expected(i);
      networkresult = run_neural_network(W, E, g);
      V = networkresult.V;
      H = networkresult.H;
      res = backpropagation_learning(W, V, H, S, eta, gp, alpha, previous_changes);
      
      W = res.W;
      previous_changes = res.changes;

      err = norm(V.(lvl(levels+1))-S);

      if err > 0.1
        flag = 0;
      end

      error(i) = err;
      result = V.(lvl(levels+1));
      current(:,i) = result;

      if norm(V.(lvl(levels+1))-S) > error_cap
        flag = 0;
      end
    end
    
    if mod(iter, 10) == 0
      item = idivide(int32(iter+10), int32(10));
      figure(1);
      hist(current-expected);
      drawnow();
      Q(item) = norm(current-expected);
      figure(2);
      plot(Q(1:item));
    end
    
    mean_error = [mean_error mean(error)];
    deviation = [deviation std(error)];

    if mod(iter, NO_VARIATION_ITERATIONS) == 0
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
    if mod(iter, 1) == 0
      x = 1 : size(mean_error, 2);
      plot(x, mean_error, 'r.-', x, deviation, 'b.-');
      display(['Going at ' num2str(iter) ' ' ]);
      drawnow
    end
      
  end
  display(['Took me ' num2str(iter) ' iterations to reduce error to < ' num2str(error_cap)])

end

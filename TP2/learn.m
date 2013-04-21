function W=learn(dataset, expected, W, eta, g, gp, cap, alpha, error_cap)

  NO_VARIATION_ITERATIONS = 3500;
  NO_VARIATION_DIFF = 0.01;

  adaptive_steps = 4;
  adaptive_increment = 0.05;
  adaptive_decrement = 0.005;
  adaptive_epsilon = 0.00001;

  levels = size(fieldnames(W), 1);
  flag = 0;
  iter = 0;
  last = [];

  mean_errors = [];
  deviation = [];
  error = zeros(size(dataset, 2), 1);
  Q = zeros(10000);

  original_alpha = alpha;
  good_steps = 0;
  rollback = 0;
  etas = [];

  while flag == 0

    idxs = randperm(size(dataset, 2));
    dataset = dataset(:,idxs);
    expected = expected(idxs);

    previous_changes = {};
    for i = 1 : levels
      name = lvl(i);
      previous_changes.(name) = zeros(size(W.(name)));
    end
    current = zeros(size(expected));

    last_weights = W;
    for i=1:size(dataset, 2)

      E = dataset(:,i);
      S = expected(i);
      networkresult = run_neural_network(W, E, g);
      V = networkresult.V;
      H = networkresult.H;
      res = backpropagation_learning(W, V, H, S, eta, gp, alpha, previous_changes);

      W = res.W;
      previous_changes = res.changes;

      result = V.(lvl(levels+1));
      current(:,i) = result;
      error(i) = norm(result - S);
    end

    mean_error = mean(error);

    if mean_error < error_cap
      flag = 1;
    elseif size(mean_errors, 2) > 0
      if mean_error + adaptive_epsilon < mean_errors(end)
        good_steps = good_steps + 1;
        alpha = original_alpha;

        if good_steps == adaptive_steps
          good_steps = 0;
          eta = eta + adaptive_increment;
        end
      elseif mean_error - adaptive_epsilon > mean_errors(end)
        good_steps = 0;
        eta = eta * (1 - adaptive_decrement);
        alpha = 0;
        rollback = 1;
      else
        good_steps = 0;
        alpha = 0;
      end
    end


    if rollback
      W = last_weights;
    else
      mean_errors = [mean_errors mean_error];
      deviation = [deviation std(error)];
    end
    rollback = 0;

    if flag == 0 && mod(iter, NO_VARIATION_ITERATIONS) == 0
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
    if mod(iter, 2) == 0
      figure(1);
      x = 1 : size(mean_errors, 2);
      plot(x, mean_errors, 'r.-', x, deviation, 'b.-');
      figure(2);
      etas = [etas eta];
      plot(etas);
      display(['Going at ' num2str(iter) ' ' num2str(mean_errors(end))]);
      drawnow
    end

    if mod(iter, 10) == 0
      item = idivide(int32(iter+10), int32(10));
      figure(3);
      hist(current-expected);
      Q(item) = norm(current-expected);
      figure(4);
      plot(Q(1:item));
      drawnow
    end
  end
  display(['Took me ' num2str(iter) ' iterations to reduce error to < ' num2str(error_cap)])

end

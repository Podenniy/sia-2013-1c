function W=learn(dataset, expected, W, eta, g, gp, alpha, error_cap, noise_factor)

  adaptive_steps = 4;
  adaptive_increment = 0.05;
  adaptive_decrement = 0.005;
  adaptive_epsilon = 0.00001;

  levels = size(fieldnames(W), 1);
  iter = 1;
  tries = 0;

  error = zeros(size(dataset, 2), 1);
  mean_errors = zeros(10000,1);

  original_alpha = alpha;
  good_steps = 0;
  rollback = 0;
  last_trial_update = 0;

  while true

    tries = tries + 1;
    idxs = randperm(size(dataset, 2));
    dataset = dataset(:,idxs);
    expected = expected(idxs);

    previous_changes = {};
    for i = 1 : levels
      name = lvl(i);
      previous_changes.(name) = zeros(size(W.(name)));
    end
    last_weights = W;
    for i=1:size(dataset, 2)

      E = dataset(:,i);
      S = expected(i);
      
      add_noise(W, ((tries - last_trial_update)^2) * noise_factor);
      networkresult = run_neural_network(W, E, g);
      V = networkresult.V;
      H = networkresult.H;
      res = backpropagation_learning(W, V, H, S, eta, gp, alpha, previous_changes);

      W = res.W;
      previous_changes = res.changes;

      result = V.(lvl(levels+1));
      error(i) = norm(result - S);
    end
    mean_error = mean(error);

    if mean_error < error_cap
      break;
    end
    
    if iter > 2
      last_mean_error = mean_errors(iter-1);
      if mean_error + adaptive_epsilon < last_mean_error
        good_steps = good_steps + 1;
        alpha = original_alpha;

        if good_steps == adaptive_steps
          good_steps = 0;
          eta = eta + adaptive_increment;
        end
      elseif mean_error - adaptive_epsilon > last_mean_error
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
      iter = iter - 1;
    else
      mean_errors(iter) = mean_error;
      last_trial_update = tries;
      plot(mean_errors(1:iter));
      plotNeural(W, ['plot' num2str(iter) '.png']);
      drawnow();
    end
    
    rollback = 0;
    iter = iter + 1;
    
    display(['iter=' num2str(iter) ', trials=' num2str(tries) ', error=' num2str(mean_error) ', noise_factor=' num2str(((tries - last_trial_update)^2) * noise_factor)]);
  end
  display(['Took me ' num2str(iter) ' iterations to reduce error to < ' num2str(error_cap)])

end

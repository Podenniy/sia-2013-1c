function data=learn(dataset, expected, W, g, gp, parameters)

  param = @(t, x)(get_default_parameter(parameters, t, x));
  % Learning factor.
  eta = param('eta', 0.4);
  % Randomize the dataset
  randomize_dataset = param('randomize_dataset', true);
  % Suggested value for alpha: 0.3
  alpha = param('alpha', 0);
  % When the mean error is lesser than 'error_cap', the algorithm halts
  error_cap = param('error_cap', 0.05);
  % Adds a percentual error to each weight of the network
  noise_factor = param('noise_factor', 0);
  % Halts after this many iterations if the error couldn't be reduced
  hard_limit = param('hard_limit', 1000);
  % Adaptative learning increment: when things look good, multiply eta by
  % 1+this value. Suggested value: 0.1
  adaptative_increment = param('adaptative_increment', 0);
  % Adaptative learning decrement: decrement eta when thing aren't going
  % well by 1-this value. Suggested value: 0.001
  adaptative_decrement = param('adaptative_decrement', 0);
  % Adaptative learning steps: after these many steps, modify eta.
  adaptative_steps = param('adaptative_steps', 3);
  % Print debug data
  debug = param('debug', false);
  
  tic;
  
  adaptative_epsilon = 0.00001;

  levels = size(fieldnames(W), 1);
  iter = 1;
  tries = 0;

  error = zeros(size(dataset, 2), 1);
  mean_errors = zeros(hard_limit,1);
  ninetile_errors = zeros(hard_limit,1);
  ETA = zeros(hard_limit,1);

  original_alpha = alpha;
  good_steps = 0;
  rollback = 0;
  last_trial_update = 0;

  while true

    if tries > hard_limit
      break;
    end
    tries = tries + 1;
    
    ETA(tries) = eta;
    if randomize_dataset
      idxs = randperm(size(dataset, 2));
    else
      idxs = 1:size(dataset, 2);
    end
    this_dataset = dataset(:,idxs);
    this_expected = expected(idxs);

    previous_changes = {};
    for i = 1 : levels
      name = lvl(i);
      previous_changes.(name) = zeros(size(W.(name)));
    end
    last_weights = W;
    for i=1:size(this_dataset, 2)

      E = this_dataset(:,i);
      S = this_expected(i);
      
      add_noise(W, ((tries - last_trial_update)^2) * noise_factor / tries);
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
      if mean_error + adaptative_epsilon < last_mean_error
        good_steps = good_steps + 1;
        alpha = original_alpha;

        if good_steps == adaptative_steps
          good_steps = 0;
          eta = eta + adaptative_increment;
        end
      elseif mean_error - adaptative_epsilon > last_mean_error
        good_steps = 0;
        eta = eta * (1 - adaptative_decrement);
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
      ninetile_errors(iter) = prctile(error, 90);
      last_trial_update = tries;
    end
    
    rollback = 0;
    iter = iter + 1;
    
    if debug
      display(['iter=' num2str(iter) ', trials=' num2str(tries) ...
               ', error=' num2str(mean_error) ', noise_factor=' ...
               num2str(((tries - last_trial_update)^2) * noise_factor / tries)]);
    end
  end
  if debug
    display( ['Took me ' num2str(iter) ' iterations to reduce error to < ' num2str(error_cap)])
  end
  data = struct('ETA', ETA, 'W', W, ...
                'mean_errors', mean_errors(1:iter-1), ...
                'ninetile_errors', ninetile_errors(1:iter-1), ...
                'iter', iter-1, 'tries', tries, 'time', toc);
end

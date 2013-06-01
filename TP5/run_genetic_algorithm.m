function data = run_genetic_algorithm(params)

  param = @(t, x)(get_default_parameter(params, t, x));
  
  replace_algorithm = param('replace_algorithm', 0);
  done = param('done', 0);
  debug = param('debug', true);
  N = param('N', 100);
  
  setup_neuronal_network_data();
  
  % status = struct(...
  %  'N', N, ...          # Number of individuals
  %  'p', population, ... # The population. Array of structs with
  %  ...                  # only one field: i (matlab sucks)
  %  'g', 1, ...          # Generation number
  %  'f_avg', 0, ...      # Average fitness
  %  'f_90th', 0, ...     # 90th percentile, fitness
  %  'f_95th', 0, ...     # 95th percentile, fitness
  %  'f_min', 0, ...      # Min fitness
  %  'f_max', 0, ...      # Max fitness
  %  'b', 0, ...          # The best individual
  %  'std', 0 ...         # fitness standard deviation
  %);
  if param('use_first_gen', 0)
    status = struct(...
      'p', params.first_generation, ...
      'N', params.N, ...
      'g', 1 ...
    );
  else
    status = get_random_population(N);
  end
  status = evaluate_population(status);
  
  data = [];   % Will contain .g fields with data about generations
  prev = 0;

  while ~done(prev, status)
    
    data(status.g).d = struct(...
      'g', status.g, ...
      'f_avg', status.f_avg, ...
      'f_90th', status.f_90th, ...
      'f_95th', status.f_95th, ...
      'f_min', status.f_min, ...
      'f_max', status.f_max, ...
      'b', status.b, ...
      'std', status.std ...
    );
    if debug
      display(['Generation ' num2str(status.g)]);
      display(['  avg: ' num2str(status.f_avg)]);
      display(['  90th: ' num2str(status.f_90th)]);
      display(['  max: ' num2str(status.f_max)]);
      display(['  std: ' num2str(status.std)]);
      plotresults(data);
      drawnow;
    end
    
    prev = status;
    status = replace_algorithm(status, params);
    status = evaluate_population(status);
  end

end
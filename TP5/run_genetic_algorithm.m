function run_genetic_algorithm(params)

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
  %  'std', 0 ...         # fitness standard deviation
  %);
  status = get_random_population(params.N);
  
  replace = params.replace_algorithm;
  done = params.done;
  
  while ~done(status)
    
    prev = status;
    status = replace(status, params);
  end

end
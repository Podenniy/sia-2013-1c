function new_pop = replace_3(population, ...
                      selection_algorithm, ...
                      selection_algorithm_2, ...
                      cross_algorithm, ...
                      mutate_algorithm, params)
                    
  % REQUIRES PARAMS TO HAVE A 'G' DEFINED, the fraction of individuals that
  % will not perish
  N = size(population, 2);
  K = ceil(params.G * N);
  
  if mod(K, 2) ~= 0
    K = K-1;
  end

  newindividuals = struct();
  parents = selection_algorithm(population, K);
  for i=1:K/2
    prnts = parents(i*2-1:i*2);
    
    [n1, n2] = cross_algorithm(prnts(1).i, prnts(2).i);
    
    n1 = mutate_algorithm(n1);
    n2 = mutate_algorithm(n2);
    
    if rand() < params.backpropagate_probablility
      n1 = backpropagate_individual(n1);
      n2 = backpropagate_individual(n2);
    end
    newindividuals(i*2).i = evaluate_individual(n1);
    newindividuals(i*2-1).i = evaluate_individual(n2);
  end
  
  all_ind = struct();
  for i = 1:N
    all_ind(i).i = population(i).i;
  end
  for i = 1:K
    all_ind(i+N).i = newindividuals(i).i;
  end
  
  new_pop = selection_algorithm_2(all_ind, N);
end
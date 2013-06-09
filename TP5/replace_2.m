function new_pop = replace_2(population, ...
                      selection_algorithm, ...
                      selection_algorithm_2, ...
                      cross_algorithm, ...
                      mutate_algorithm, status, params)

  % REQUIRES PARAMS TO HAVE A 'G' DEFINED, the fraction of individuals that
  % will not perish
  N = size(population, 2);
  K = ceil(params.G * N);

  if mod(K, 2) ~= 0
    K = K-1;
  end

  new_pop = struct();
  parents = selection_algorithm(population, K, status);
  for i=1:K/2
    prnts = parents(i*2-1:i*2);

    [n1, n2] = cross_algorithm(prnts(1).i, prnts(2).i);

    n1 = mutate_algorithm(n1, params.pm);
    n2 = mutate_algorithm(n2, params.pm);

    if rand() < params.backpropagate_probablility
      n1 = backpropagate_individual(n1);
      n2 = backpropagate_individual(n2);
    end
    new_pop(i*2).i = evaluate_individual(n1);
    new_pop(i*2-1).i = evaluate_individual(n2);
  end

  keep = selection_algorithm_2(population, N-K, status);
  for i=K+1:N
    new_pop(i).i = keep(i-K).i;
  end
end

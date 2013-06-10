function new_pop = replace_1(population, ...
                      selection_algorithm, ...
                      selection_algorithm_2, ...
                      cross_algorithm, ...
                      mutate_algorithm, status, params)

  N = size(population, 2);
  new_pop = struct();
  parents = selection_algorithm(population, N, status);
  for i=1:N/2
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

end

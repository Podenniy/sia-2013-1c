function new_pop = select_1(population, ...
                      selection_algorithm, ...
                      unused_selection_algorithm_2, ...
                      cross_algorithm, ...
                      mutate_algorithm)
                    
  N = size(population, 2);
  new_pop = struct();
  for i=1:N/2
    parents = selection_algorithm(population, 2);
    
    [n1, n2] = cross_algorithm(parents(1).i, parents(2).i);
    
    n1 = mutate_algorithm(n1);
    n2 = mutate_algotithm(n2);
    
    n1 = backpropagate_individual(n1);
    n2 = backpropagate_individual(n2);
    
    new_pop(i*2).i = n1;
    new_pop(i*2+1).i = n2;
  end
  
end
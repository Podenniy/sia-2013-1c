function g = testroulette()

  individuals = [ ...
    struct('fitness', 1), ...
    struct('fitness', 2)
  ];
  
  g = stochastic_selection(individuals, 9);
end
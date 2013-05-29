function g = testboltzmann()

  individuals = [ ...
    struct('fitness', 1), ...
    struct('fitness', 2)
  ];
  
  g = boltzmann(individuals, 9, 10);
  g = boltzmann(individuals, 9, 5);
  g = boltzmann(individuals, 9, 3);
  g = boltzmann(individuals, 9, 2);
  g = boltzmann(individuals, 9, 1.5);
  g = boltzmann(individuals, 9, 1);
  g = boltzmann(individuals, 9, 0.75);
  g = boltzmann(individuals, 9, 0.3);
end
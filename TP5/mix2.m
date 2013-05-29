function t=mix2(individuals, M, M1)

  t = [elite(individuals, M1), stochastic_selection(individuals, M-M1)];

end
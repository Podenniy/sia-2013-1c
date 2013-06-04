function t=mix2(individuals, M, fraction)

  M1 = floor(fraction*M);
  if mod(M1, 2) == 1
    M1 = M1 - 1;
  end
  t = [elite(individuals, M1), stochastic_selection(individuals, M-M1)];

end
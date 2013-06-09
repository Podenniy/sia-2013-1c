function t=mix1(individuals, M, fraction)

  M1 = floor(fraction*M);
  if mod(M1, 2) == 1
    M1 = M1 - 1;
  end
  t = [elite(individuals, M1), roulette(individuals, M-M1)];

end
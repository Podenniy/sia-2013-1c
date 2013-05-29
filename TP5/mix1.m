function t=mix1(individuals, M, M1)

  t = [elite(individuals, M1), roulette(individuals, M-M1)];

end
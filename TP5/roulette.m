function t=roulette(individuals, M)

  N = size(individuals, 2);
  t = [];

  chances = zeros(N, 1);
  cumm = 0;
  for i=1:N
    cumm = cumm + individuals(i).fitness;
    chances(i) = cumm;
  end
  for i=1:N
    chances(i) = chances(i) / cumm;
  end
  
  for i=1:M
    % TODO: Binary search this
    r = rand();
    selected = 1;
    for j=2:N
      if chances(j) < r
        selected = j;
      end
    end
    t(i).i = individuals(selected);
  end
end
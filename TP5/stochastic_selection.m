function t=stochastic_selection(individuals, M)

  N = size(individuals, 2);
  t = [];

  minchances = zeros(N, 1);
  chances = zeros(N, 1);
  cumm = 0;
  for i=1:N
    cumm = cumm + individuals(i).i.f;
    chances(i) = cumm;
  end
  for i=1:N
    chances(i) = chances(i) / cumm;
  end
  for i=2:N
    minchances(i) = chances(i-1);
  end
  
  r = rand();
  k = 1/M;
  selected = 1;
  for i=1:M
    while minchances(selected) > r || ...
          r > chances(selected)
      selected = selected + 1;
      if selected == N + 1
        selected = 1;
      end
    end
    t(i).i = individuals(selected).i;
    r = r + k;
    if r > 1
      r = r - 1;
    end
  end
end
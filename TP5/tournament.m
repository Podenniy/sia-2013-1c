function t=tournament(individuals, M, chance)

  N = size(individuals, 2);
  t = [];
  
  for i=1:M
    x = randi([1, N]);
    y = randi([1, N]);
    while y == x
      y = randi([1, N]);
    end
    fx = individuals(x).i.f;
    fy = individuals(y).i.f;
    r = rand();
    if r < chance
      if fy > fx
        t(i).i = individuals(y).i;
      else
        t(i).i = individuals(x).i;
      end
    else
      if fy > fx
        t(i).i = individuals(x).i;
      else
        t(i).i = individuals(y).i;
      end
  end
end
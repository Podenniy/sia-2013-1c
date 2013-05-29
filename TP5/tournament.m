function t=tournament(individuals, M, chance)

  N = size(individuals, 2);
  t = [];
  
  for i=1:M
    x = randi([1, N]);
    y = randi([1, N]);
    while y == x
      y = randi([1, N]);
    end
    fx = individuals(x).fitness;
    fy = individuals(y).fitness;
    r = rand();
    if r < chance
      if fy > fx
        t(i).i = individuals(y);
      else
        t(i).i = individuals(x);
      end
    else
      if fy > fx
        t(i).i = individuals(x);
      else
        t(i).i = individuals(y);
      end
  end
end
function t=elite(individuals, M)

  N = size(individuals, 2);
  t = [];

  ranks = zeros(N, 2);
  for i=1:N
    ranks(i,:) = [individuals(i).fitness, i];
  end
  ranks = sortrows(ranks);
  
  for i=N-M+1:N
    t(i-N+M).i = individuals(ranks(i, 2));
  end

end
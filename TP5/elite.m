function t=elite(individuals, M, unused_state)

  N = size(individuals, 2);
  t = [];

  ranks = zeros(N, 2);
  for i=1:N
    ranks(i,:) = [individuals(i).i.f, i];
  end
  ranks = sortrows(ranks);
  
  for i=N-M+1:N
    t(i-N+M).i = individuals(ranks(i, 2)).i;
  end

end
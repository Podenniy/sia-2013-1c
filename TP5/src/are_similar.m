function t=are_similar(p1, p2, difference)

  N = size(p1.p, 2);
  
  test = N/4;
  t1 = randi(N, test);
  t2 = randi(N, test);
  
  t = 0;
  for i=1:test
    t = t + abs(difference_neural(p1.p(t1(i)).allels, p2.p(t2(i)).allels));
  end
end
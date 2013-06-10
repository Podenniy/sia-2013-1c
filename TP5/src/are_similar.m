function t=are_similar(p1, p2, difference)

  N = size(p1.p, 2);
  
  t=0;
  for t1=1:N
    for t2=1:N
      t = t + abs(difference_neural(p1.p(t1).allels, p2.p(t2).allels));
    end
  end
end
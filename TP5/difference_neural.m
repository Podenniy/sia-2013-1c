function d = difference_neural(allels1, allels2)

  d= 0;
  for i=1:size(allels1, 1)
    d = d + abs(allels1(i) - allels2(i));
  end
  
end
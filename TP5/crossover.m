function u, v = crossover(i1, i2)
  
  N = size(i1.allels, 2);
  i = randi(1:N);
  
  allels1 = [i1.allels[1:i], i2.allels[i+1:N]];
  allels2 = [i2.allels[1:i], i1.allels[i+1:N]];
  
  u = unflatten(i1.structure, allels1);
  v = unflatten(i1.structure, allels2);
end
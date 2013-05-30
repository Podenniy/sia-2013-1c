function u, v = double_crossover(i1, i2)
  
  N = size(i1.allels, 2);
  i = sort([randi([1,N]), randi([1,N])]);
  
  t1 = i(1);
  t2 = i(2);
  
  N = size(i1.allels, 2);
  i = randi(1:N);
  
  allels1 = [i1.allels[   1:t1],...
             i2.allels[t1+1:t2],...
             i1.allesl[t2+1:N ]);
           
  allels2 = [i2.allels[   1:t1],...
             i1.allels[t1+1:t2],...
             i2.allesl[t2+1:N ]);

  u = unflatten(i1.structure, allels1);
  v = unflatten(i1.structure, allels2);
                
end
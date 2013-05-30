function [u, v] = double_crossover(i1, i2)
  
  u = struct();
  v = struct();
  
  u.inner_structure = i1.inner_structure;
  u.structure = i1.structure;
  v.inner_structure = i1.inner_structure;
  v.structure = i1.structure;
  u.W = i1.W;
  v.W = i1.W;

  N = size(i1.allels, 1);
  i = sort([randi([1,N]), randi([1,N])]);
  
  t1 = i(1);
  t2 = i(2);
  
  allels1 = [i1.allels(   1:t1,:);...
             i2.allels(t1+1:t2,:);...
             i1.allels(t2+1:N ,:)];
           
  allels2 = [i2.allels(   1:t1,:);...
             i1.allels(t1+1:t2,:);...
             i2.allels(t2+1:N ,:)];

  u.allels = allels1;
  u = unflatten(u);
  u.fitness = fitness(u);

  v.allels = allels2;
  v = unflatten(v);
  v.fitness = fitness(v);
end
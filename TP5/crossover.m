function [u, v] = crossover(i1, i2)
  
  u = struct();
  v = struct();
  
  u.inner_structure = i1.inner_structure;
  u.structure = i1.structure;
  v.inner_structure = i1.inner_structure;
  v.structure = i1.structure;
  u.W = i1.W;
  v.W = i1.W;
  
  N = size(i1.allels, 1);
  i = randi([1,N]);
  
  allels1 = [i1.allels(1:i,:); i2.allels(i+1:N,:)];
  allels2 = [i2.allels(1:i,:); i1.allels(i+1:N,:)];
  
  u.allels = allels1;
  v.allels = allels2;

  u = unflatten(u);
  u.fitness = fitness(u);
  v = unflatten(v);
  v.fitness = fitness(v);
end
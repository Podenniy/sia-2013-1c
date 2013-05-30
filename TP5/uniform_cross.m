function [u, v] = uniform_cross(i1, i2, p)
    
  u = struct();
  v = struct();
  
  u.inner_structure = i1.inner_structure;
  u.structure = i1.structure;
  v.inner_structure = i1.inner_structure;
  v.structure = i1.structure;
  u.W = i1.W;
  v.W = i1.W;
  
  N = size(i1.allels, 1);
  
  v1 = i1.allels;
  v2 = i2.allels;
  
  allels1 = zeros(N, 1);
  allels2 = zeros(N, 1);
  
  for i=1:N
    if rand() > p
      allels1(i) = v2(i);
      allels2(i) = v1(i);
    else
      allels1(i) = v1(i);
      allels2(i) = v2(i);
    end
  end
  
  u.allels = allels1;
  v.allels = allels2;

  u = unflatten(u);
  u.fitness = fitness(u);
  v = unflatten(v);
  v.fitness = fitness(v);
                
end
function u, v = uniform_cross(i1, i2, p)
  
  N = size(i1.allels, 2);
  
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

  u = unflatten(i1.structure, allels1);
  v = unflatten(i1.structure, allels2);
                
end
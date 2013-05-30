function t=universal_mutate(t, pm, cap)

  N = size(t.allels, 1);
  
  for i=1:N
    if rand() < pm
      t.allels(i) = rand*cap*2-0.5; 
    end
  end
  t = unflatten(t);  
end
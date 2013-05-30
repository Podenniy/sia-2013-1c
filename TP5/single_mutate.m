function t=single_mutate(t, pm, random_value)
  
  r = rand();
  
  if r < pm
    N = size(t.allels, 1);
    ind = randi([1,N]);
    t.allels(ind) = random_value;
    t = unflatten(t);
  end
  
end
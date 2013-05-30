function t = unflatten(structure, allels)
  
  t = struct();
  
  t.allels = allels;
  t.structure = structure;
  
  t.W = struct();
  i = 1;
  for level=1:size(levels,2)-1
    level_len = t.structure(level);
    t.W.(char('@' + level)) = allels(i:i+level_len-1);
    i = i + level_len;
  end
  
  t.fitness = fitness(t.W);
  
end
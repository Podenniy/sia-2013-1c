function nodes = plotNeural(W)

  nodes = [];
  display('digraph{');
  
  w = W.(lvl(1));
  level_names = ['Z'];
  for j=1:size(w, 2)-1
    nodes = [nodes; j, 0, 0];
    display([' Z_' num2str(j) ' [label="' num2str(j) '"];']);
  end
  
  limits = [0, size(nodes, 1)];
  
  for level=1:size(fieldnames(W), 1)
    name = lvl(level);
    w = W.(name);
    level_names = [level_names; name];
    
    for j=1:size(w, 1)
      nodes = [nodes; j, level, w(j, end)];
      display([' ' name '_' num2str(j) ' [label="' num2str(level) '_' num2str(j) '"];']);
    end
    
    limits = [limits, limits(end) + size(w, 1)];
  end
  
  edges = [];
  for level=1:size(fieldnames(W), 1)
    name = lvl(level);
    w = W.(name);
    
    for j=1:size(w, 1)
      for i=1:size(w, 2)-1
        edges = [edges; limits(level)+i, limits(level+1)+j, w(j,i)];
        display([' ' level_names(level) '_' num2str(i) ' -> ' level_names(level+1) '_' num2str(j) ' [label="' num2str(w(j,i)) '"];']);
      end
    end
  end
  display('};');
  % grPlot(nodes, edges);

end
function plotNeural(W, filename)

  nodes = [];
  f = fopen(filename, 'w');
  fprintf(f, 'digraph{');
  
  fprintf(f, ' splines = false;');
  
  w = W.(lvl(1));
  level_names = ['Z'];
  for j=1:size(w, 2)-1
    nodes = [nodes; j, 0, 0];
    fprintf(f, [' Z_' num2str(j) ' [label="' num2str(j) '"];']);
  end
  
  limits = [0, size(nodes, 1)];
  
  top_value = 0;
  
  for level=1:size(fieldnames(W), 1)
    name = lvl(level);
    w = W.(name);
    top_value = max(top_value, max(max(abs(w))));
    level_names = [level_names; name];
    
    for j=1:size(w, 1)
      nodes = [nodes; j, level, w(j, end)];
      fprintf(f, [' ' name '_' num2str(j) ' [label="' num2str(j) '(' num2str(w(j, end)) ')"];']);
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
        
        if w(j,i) > 0
          color = ['0,1,' num2str(0.5 + (w(j,i) / top_value)/2)];
        else
          color = ['0.65,1,0.5'];
        end
        fprintf(f, [' ' level_names(level) '_' num2str(i) ' -> ' level_names(level+1) '_' num2str(j) ' [color="' color '", penwidth=' num2str(abs(w(j,i))) '];']);
      end
    end
  end
  fprintf(f, '}');

end
function y = get_lvls(W)
  y = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  y = y(1,1:numel(fieldnames(W))+1)';
end
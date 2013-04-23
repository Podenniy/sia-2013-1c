function print_matrix(W)

  display('W = struct();')
  lvl = get_lvls(W);
  for i=1:size(lvl,1)-1
    display(['W.' lvl(i) ' = [']);
    w = W.(lvl(i));
    for j=1:size(w, 1)
      display(['    ' num2str(w(j,:)) ';']);
    end
    display('];');
  end
end
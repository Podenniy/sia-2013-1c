function t = flatten(t)

  W = t.W;
  lvl = get_lvls(W);
  levels = size(lvl, 1)-1;
  t.inner_structure = zeros(levels, 1);
  allels = [];

  for level = 1:levels
    name = lvl(level);
    p = size(W.(name));
    t.structure(level) = p(2)-1;
    t.inner_structure(level) = p(1) * p(2);
    allels = [allels; reshape(W.(name), [], 1)];
  end
  t.structure(levels+1) = 1;
  t.allels = allels;
end
function t = unflatten(t)

  lvl = get_lvls(t.W);
  levels = size(lvl, 1)-1;

  i = 1;
  for level=1:levels
    level_len = t.inner_structure(level);
    cols = t.structure(level)+1;
    rows = level_len / cols;
    t.W.(char('@' + level)) = reshape(...
      t.allels(i:i+level_len-1), rows, cols);
    i = i + level_len;
  end
end
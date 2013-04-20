function W = get_random_w(levels, abs_cap)

  % This function takes a number in the interval [0,1]
  % and maps to one in [-abs_cap,abs_cap]
  cap = @(R)(R-0.5).*abs_cap.*2;

  W = struct();
  for level=1:cols(levels)-1
    W.(lvl(level)) = cap(rand(levels(level+1), levels(level)+1));
  end
end

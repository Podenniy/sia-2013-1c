function y = rows(x)
  y = size(x)(1);
endfunction

function y = cols(x)
  y = size(x)(2);
endfunction

function y = lvl(x)
  y = char(x .+ toascii('@'));
endfunction

function [V, H] = run_network(W, g, E)
  O = E;
  V = struct();
  H = struct();
  levels = nfields(W);
  for level=1:levels           # For each layer of the network
      name = lvl(level);
      w = W.(name);         # using the weight matrix
      h = w * [O; -1];       # Add the threshold -1 at the end
      O = g(h);              # get the output vector
      V.(name) = O;
      H.(name) = h;
  endfor
endfunction

function W = get_random_w(levels, neurons_in_level, abs_cap = 0.3)

  # This function takes a number in the interval [0,1]
  # and maps to one in [-abs_cap,abs_cap] 
  cap = @(R)(R.-0.5).*abs_cap.*2;

  W = struct();
  for level=1:levels-1
    W.(lvl(level)) = cap(rand(neurons_in_level, neurons_in_level + 1));
  endfor
  W.(lvl(levels)) = cap(rand(1, neurons_in_level + 1));
endfunction

function y = g(x)
  y = atan(x);
endfunction

function y = gp(x)
  y = 1 / (1 + x.^2);
endfunction

function W = backpropagation_learning(W, V, H, gp, S, eta)

  levels = nfields(W);
  last_level = lvl(levels);

  # First step of the backpropagation
  last_delta = gp(H.(last_level)) .* (S-V.(last_level));
  W.(last_level) = W.(last_level) + (eta .* last_delta * V.(last_level)');

  for level = levels-1:-1:1

    name = lvl(level);
    next = lvl(level+1);
    next_w = W.(next);
    next_w = next_w(:,1:cols(next_w)-1);
    last_delta = gp(H.(name)) .* (next_w * last_delta');
    W.(name) = W.(name) + eta .* (last_delta * V.(name));

  endfor
endfunction

function W=learn(dataset, expected, levels, neurons, g, gp, eta)

  W = get_random_w(levels, neurons);
  levels = nfields(W);
  flag = 0;

  while flag == 0

    flag = 1;

    for i=1:size(dataset)(2)

      E = dataset(:,i);
      S = expected(i);
      [V, H] = run_network(W, @g, E);
      W = backpropagation_learning(W, V, H, @gp, S, eta);
      display(W);

      if abs(V.(lvl(levels))-S) > 0.0001
        flag = 0;
      endif

    endfor

  endwhile

endfunction


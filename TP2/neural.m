a=1;

function y = rows(x)
  y = size(x)(1);
endfunction

function y = cols(x)
  y = size(x)(2);
endfunction

function [V, H] = run_network(W, g, E)
  O = E;
  V = struct();
  H = struct();
  levels = nfields(W);
  for level=1:levels           # For each layer of the network
      name = '@' + level;
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
    W.('@' + level) = cap(rand(neurons_in_level, neurons_in_level + 1));
  endfor
  W.('@' + levels-1) = cap(rand(1, neurons_in_level + 1));
endfunction

function y = g(x)
  y = atan(x);
endfunction

function y = gp(x)
  y = 1 / (1 + x.^2);
endfunction

function W = backpropagation_learning(W, V, H, gp, S, eta)

  levels = nfields(W);
  last_level = '@' + levels;

  # First step of the backpropagation
  last_delta = gp(H.(last_level)) .* (S-V.(last_level));
  W.(last_level) = W.(last_level) + (eta .* last_delta * V.(last_level)');

  for level = last_level-1:-1:'A'

    current_w = W.(level);
    last_delta = gp(H.(level)) .* current_w * last_delta;
    W.(level) = current_w + eta .* last_delta * V.(level)';

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

      if abs(V.('@' + levels)-S) > 0.0001
        flag = 0;
      endif

    endfor

  endwhile

endfunction


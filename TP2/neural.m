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

  V.(lvl(1)) = O;

  levels = nfields(W);
  for level=1:levels           # For each layer of the network
      name = lvl(level);
      w = W.(name);         # using the weight matrix
      h = w * [O; -1];       # Add the threshold -1 at the end
      O = g(h);              # get the output vector
      V.(lvl(level + 1)) = O;
      H.(name) = h;
  endfor
endfunction

function W = get_random_w(levels, neurons_in_level, abs_cap = 0.8)

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

  delta = struct();

  # First step of the backpropagation
  delta.(last_level) = gp(H.(last_level)) .* (S-V.(lvl(levels + 1)));

  for level = levels-1:-1:1
    name = lvl(level);
    next = lvl(level+1);

    next_w = W.(next);
    delta.(name) = [gp(H.(name)) 1] .* (next_w * delta.(next)');
  endfor



  for level = levels:-1:1

    name = lvl(level);
     level_delta = delta.(name);
     level_inputs = [V.(name) ; -1];

    #delta
    #V.(name)
    #weights = delta.(name)' * [V.(name); -1]'
    #W.(name) = W.(name) + eta .* weights(1:rows(weights)-1,:);


     w = W.(name);

     [num_rows, num_cols] = size(w);

     w;

     for i = 1:num_rows
       for j = 1:num_cols
         i;
         j;
         w(i,j) = w(i,j) + eta * level_delta(i) * level_inputs(j);
       endfor
     endfor

     W.(name) = w;

  endfor

endfunction

function W=learn(dataset, expected, levels, neurons, g, gp, eta)

  W = get_random_w(levels, neurons);
  levels = nfields(W);
  flag = 0;

  old_w = W.(lvl(levels));

  while flag == 0

    for i=1:size(dataset)(2)

      E = dataset(:,i);
      S = expected(i);
      [V, H] = run_network(W, @g, E);
      W = backpropagation_learning(W, V, H, @gp, S, eta);
      display(W);
      display(V);

      if abs(V.(lvl(levels+1))-S) < 0.0001
        flag = 1;
      endif

      disp(abs(V.(lvl(levels+1))-S));
      disp(sum(abs(W.(lvl(levels)) - old_w)));
      old_w = W.(lvl(levels));

    endfor

  endwhile

endfunction


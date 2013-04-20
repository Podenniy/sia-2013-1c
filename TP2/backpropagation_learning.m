function W = backpropagation_learning(W, V, H, S, eta)

  levels = size(W);
  levels = levels(1);
  last_level = lvl(levels);

  delta = struct();

  % First step of the backpropagation
  delta.(last_level) = gp(H.(last_level)) .* (S-V.(lvl(levels + 1)));

  for level = levels-1:-1:1
    name = lvl(level);
    next = lvl(level+1);

    next_w = W.(next);
    delta.(name) = [gp(H.(name)) 1] .* (next_w * delta.(next)');
  end



  for level = levels:-1:1

    name = lvl(level);
     level_delta = delta.(name);
     level_inputs = [V.(name) ; -1];

    %delta
    %V.(name)
    %weights = delta.(name)' * [V.(name); -1]'
    %W.(name) = W.(name) + eta .* weights(1:rows(weights)-1,:);


     w = W.(name);

     [num_rows, num_cols] = size(w);

     w;

     for i = 1:num_rows
       for j = 1:num_cols
         i;
         j;
         w(i,j) = w(i,j) + eta * level_delta(i) * level_inputs(j);
       end
     end

     W.(name) = w;

  end
end
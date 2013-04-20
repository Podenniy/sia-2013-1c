function out = backpropagation_learning(W, V, H, S, eta, gp, alpha, previous_changes)

  levels = size(fieldnames(W), 1);
  last_level = lvl(levels);

  delta = struct();

  % First step of the backpropagation
  delta.(last_level) = [gp(H.(last_level)) .* (S-V.(lvl(levels + 1))) ; 0];

  for level = levels-1:-1:1
    name = lvl(level);
    next = lvl(level+1);

    next_w = W.(next);
    delta.(name) = [gp(H.(name)) ; 1] .* (next_w' * delta.(next)(1:end-1));
  end


  changes = {};

  for level = levels:-1:1

    name = lvl(level);
    level_delta = delta.(name);
    level_inputs = [V.(name) ; -1];
    w = W.(name);

    [num_rows, num_cols] = size(w);
    change_in_level = zeros(num_rows, num_cols);
    for i = 1:num_rows
      for j = 1:num_cols
        change_in_level(i, j) = eta * level_delta(i) * level_inputs(j);
      end
    end

    change_in_level = change_in_level + alpha .* previous_changes.(name);
    W.(name) = w + change_in_level;
    changes.(name) = change_in_level;
  end
  
  out = {};
  out.W = W;
  out.changes = changes;
end

function W=learn(dataset, expected, levels_sizes, eta)

  W = struct();
  W = get_random_w(levels_sizes, 0.3);
  levels_ = size(W);
  levels = levels_(1);
  flag = 0;

  old_w = W.(lvl(levels));

  P = [];
  % while flag == 0
  for k=1:500

    for i=1:size(dataset)

      E = dataset(:,i);
      S = expected(i);
      networkresult = run_neural_network(W, E);
      V = networkresult.V;
      H = networkresult.H;
      W = backpropagation_learning(W, V, H, S, eta);
      % display(W);
      % display(V);
      P = [P sum(abs(V.(lvl(levels+1))-S))];

      if abs(V.(lvl(levels+1))-S) < 0.0001
        flag = 1;
      end

      % disp(abs(V.(lvl(levels+1))-S));
      % disp(sum(abs(W.(lvl(levels)) - old_w)));
      old_w = W.(lvl(levels));

    end

  %endwhile
  end
  plot(P);

end

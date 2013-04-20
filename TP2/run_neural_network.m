function rest = run_neural_network(W, E)
  O = E;
  V = struct();
  H = struct();

  V.(lvl(1)) = O;

  levels = size(W); levels = levels(1);
  for level=1:levels           % For each layer of the network
      name = lvl(level);
      w = W.(name);            % using the weight matrix
      h = w * [O; -1];         % Add the fake -1 neuron at the end
      O = g(h);                % get the output vector
      V.(lvl(level + 1)) = O;
      H.(name) = h;
  end
  rest = struct();
  rest.V = V;
  rest.H = H;
end
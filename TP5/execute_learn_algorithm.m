function data = execute_learn_algorithm(W, matrix_topology, g, gp, window_size, params)

  global dataset expected;
	data = learn(dataset, expected, W, g, gp, params);

end

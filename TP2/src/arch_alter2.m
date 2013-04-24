% Run the learn algorithm.

a = [2 5 4 1];
b = [3 10 6 1];
c = [2 10 6 1];
d = [2 4 2 1];
e = [3 14 8 1];

function run_test(levels)
      
      g = @sigmod;
      gp = @sigmod_derivative;

      params = struct(...
        'eta', 0.3, ...
        'alpha', 0.3, ...
        'hard_limit', 1500, ...
        'adaptative_increment', 0.0001, ...
        'adaptative_decrement', 0.01, ...
        'adaptative_steps', 4, ...
        'debug', false ...
      );

      NEURONS = levels(2:length(levels));
      DIMS = levels(1);
      W = get_random_w(levels, 0.2);

      disp('Executing learn algorithm with topology:');disp(levels);
      execute_learn_algorithm(W, NEURONS, g, gp, DIMS, params);
end


run_test(a);
run_test(b);
run_test(c);
run_test(d);
run_test(e);

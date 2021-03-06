%
1;

setup_neuronal_network_data();
replace_algorithms = struct();

%replace_algorithms(1).func = @replace_2;
%replace_algorithms(1).name = 'replace_2';
replace_algorithms(1).func = @replace_3;
replace_algorithms(1).name = 'replace_3';

needs_G = [true, true];

N_range = [80];

% G_range = [0.6 0.9];
G_range = [0.6 0.75 0.9];

selection_algorithms = struct();

selection_algorithms(1).func = @(x, y, z)(mix2(x, y, 0.3));
selection_algorithms(1).name = 'mix stochastic + 30% elite';

mutation_algorithms = struct();

mutation_algorithms(1).name = 'no mutation';
mutation_algorithms(1).func = @(x)(x);
mutation_algorithms(1).pm = 1;

cross_algorithms = struct();

cross_algorithms(1).name = 'anular, L = 10';
cross_algorithms(1).func = @(x, y)(anular(x, y, 10));

fitness_100 = fitness_limit(10000);
generations_200 = generation_limit(200);


% Cut if reaches 0.01 error or at 200 generations
cut_condition = @(x, y)(fitness_100(x, y) || generations_200(x, y));

for N = N_range

  rand('seed', 0);
  randn('seed', 0);
  initial_population = load('initial_80.m');
  initial_population = initial_population.t;

  for i2 = 1:size(replace_algorithms, 2)
    replace_algorithm = replace_algorithms(i2).func;

    for G = G_range

      for i4 = 1
        selection_algorithm = selection_algorithms(i4).func;

        for i5 = 1
          selection_algorithm_2 = selection_algorithms(i5).func;

          for i6 = 1:size(mutation_algorithms, 2)
            mutation_algorithm = mutation_algorithms(i6).func;

            for i7 = 1:size(cross_algorithms, 2)
              cross_algorithm = cross_algorithms(i7).func;

              params = struct(...
                'N', N, ...
                'G', G, ...
                'replace_algorithm', generate_replace_algorithm(replace_algorithm), ...
                'selection_algorithm', selection_algorithm, ...
                'selection_algorithm_2', selection_algorithm_2, ...
                'cross_algorithm', cross_algorithm, ...
                'mutate_algorithm', mutation_algorithm, ...
                'backpropagate_probablility', 0.05, ...
                'done', cut_condition, ...
                'use_first_gen', true, ...
                'first_generation', initial_population.p, ...
                'debug', true, ...
                'mutate_cycle', 1, ...
                'c', 0.0015, ...
                'pm', mutation_algorithms(i6).pm ...
              );

              filename = ['resultado_' datestr(now,30) '.mat'];
              disp(['=====================================']);
              disp(['Using N: ' num2str(N)]);
              disp(['Using replace algorithm: ' replace_algorithms(i2).name]);
              disp(['Using G: ' num2str(G)]);
              disp(['Using selection algorithm: ' selection_algorithms(i4).name]);
              disp(['Using selection algorithm 2: ' selection_algorithms(i5).name]);
              disp(['Using mutation algorithm: ' mutation_algorithms(i6).name]);
              disp(['Using cross algorithm: ' cross_algorithms(i7).name]);

              data = struct();
              tic;
              data.status = run_genetic_algorithm(params);
              runtime = toc;

              disp(['Running time: ' num2str(runtime)]);
              disp(['Saving into file: ' filename]);

              data.N = N;
              data.G = G;
              data.replace_algorithm = replace_algorithms(i2).name;
              data.selection_algorithm = selection_algorithms(i4).name;
              data.selection_algorithm_2 = selection_algorithms(i5).name;
              data.cross_algorithm = cross_algorithms(i7).name;
              data.mutation_algorithm = mutation_algorithms(i6).name;
              data.runtime = runtime;

              save('-v7', filename, 'data');

            end
          end
        end
      end
    end
  end
end

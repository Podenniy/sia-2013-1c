%
1;

setup_neuronal_network_data();
replace_algorithms = struct();

replace_algorithms(1).func = @replace_1;
replace_algorithms(1).name = 'replace_1';

needs_G = [false];

N_range = [6 20 80 160];

G_range = [0.6 0.9];

selection_algorithms = struct();

selection_algorithms(1).func = @elite;
selection_algorithms(1).name = 'elite';
selection_algorithms(2).func = @rank_select;
selection_algorithms(2).name = 'rank_select';
selection_algorithms(3).func = @roulette;
selection_algorithms(3).name = 'roulette';
selection_algorithms(4).func = @(x, y, z)(tournament(x, y, 0.75));
selection_algorithms(4).name = 'tournament 0.75';
selection_algorithms(5).func = @(x, y, z)(boltzmann(x, y, z.g));
selection_algorithms(5).name = 'boltzmann T = generations';
selection_algorithms(6).func = @(x, y, z)(boltzmann(x, y, 0.5*z.g));
selection_algorithms(6).name = 'boltzmann T = 0.5 * generations';
selection_algorithms(7).func = @(x, y, z)(mix1(x, y, 0.3));
selection_algorithms(7).name = 'mix roulette + 30% elite';
selection_algorithms(8).func = @(x, y, z)(mix1(x, y, 0.7));
selection_algorithms(8).name = 'mix roulette + 70% elite';
selection_algorithms(9).func = @(x, y, z)(mix2(x, y, 0.3));
selection_algorithms(9).name = 'mix stochastic + 30% elite';
selection_algorithms(10).func = @(x, y, z)(mix2(x, y, 0.7));
selection_algorithms(10).name = 'mix stochastic + 70% elite';
selection_algorithms(11).func = @(x, y, z)([x, y]);
selection_algorithms(11).name = 'None';

mutation_algorithms = struct();

mutation_algorithms(1).name = 'no mutation';
mutation_algorithms(1).func = @(x)(x);

cross_algorithms = struct();

cross_algorithms(1).name = 'single crossover';
cross_algorithms(1).func = @crossover;

fitness_100 = fitness_limit(100);
generations_200 = generation_limit(200);


% Cut if reaches 0.01 error or at 200 generations
cut_condition = @(x, y)(fitness_100(x, y) || generations_200(x, y));

for N = N_range
  
  rand("seed", 0);
  randn("seed", 0);
  initial_population = get_random_population(N);

  for i2 = 1:size(replace_algorithms, 2)
    replace_algorithm = replace_algorithms(i2).func;
    
    if needs_G(i2)
      G_target = G_range;
      selection_2_target = 1:(size(selection_algorithms, 2)-1);
    else
      G_target = 1:1;
      selection_2_target = size(selection_algorithms, 2);
    end
    for G = G_target
      
      for i4 = 1:(size(selection_algorithms, 2)-1)
        selection_algorithm = selection_algorithms(i4).func;
        
        for i5 = selection_2_target
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
                'backpropagate_probablility', 0.1, ...
                'done', cut_condition, ...
                'use_first_gen', true, ...
                'first_generation', initial_population.p, ...
                'debug', true ...
              );
            
              filename = ['resultado_' datestr(now,30) '.mat'];
              display(['=====================================']);
              display(['Using N: ' num2str(N)]);
              display(['Using replace algorithm: ' replace_algorithms(i2).name]);
              display(['Using G: ' num2str(G)]);
              display(['Using selection algorithm: ' selection_algorithms(i4).name]);
              display(['Using selection algorithm 2: ' selection_algorithms(i5).name]);
              display(['Using mutation algorithm: ' mutation_algorithms(i6).name]);
              display(['Using cross algorithm: ' cross_algorithms(i7).name]);
              
              data = struct();
              tic;
              data.status = run_genetic_algorithm(params);
              runtime = toc;
              
              display(['Running time: ' num2str(runtime)]);
              display(['Saving into file: ' filename]);
              
              data.N = N;
              data.G = G;
              data.replace_algorithm = replace_algorithms(i2).name;
              data.selection_algorithm = selection_algorithms(i4).name;
              data.selection_algorithm_2 = selection_algorithms(i5).name;
              data.cross_algorithm = cross_algorithms(i7).name;
              data.mutation_algorithm = mutation_algorithms(i6).name;
              data.runtime = runtime;
              
              save(filename, 'data');
              
            end
          end
        end
      end
    end
  end
end

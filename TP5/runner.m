setup_neuronal_network_data();

replace_algorithms = struct();
replace_algorithms(1).func = @replace_1;
replace_algorithms(1).name = 'replace_1';
replace_algorithms(2).func = @replace_2;
replace_algorithms(2).name = 'replace_2';
replace_algorithms(3).func = @replace_3;
replace_algorithms(3).name = 'replace_3';

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

cross_algorithms = struct();
cross_algorithms(1).name = 'anular, L = 10';
cross_algorithms(1).func = @(x, y)(anular(x, y, 10));
cross_algorithms(2).name = 'anular, L = 30';
cross_algorithms(2).func = @(x, y)(anular(x, y, 30));
cross_algorithms(3).name = 'single crossover';
cross_algorithms(3).func = @(x, y)(crossover(x, y));
cross_algorithms(4).name = 'double crossover';
cross_algorithms(4).func = @(x, y)(double_crossover(x, y));
cross_algorithms(5).name = 'uniform crossover 0.6';
cross_algorithms(5).func = @(x, y)(uniform_cross(x, y, 0.6));

mutation_algorithms = struct();
mutation_algorithms(1).name = 'single mutation 90% of individuals';
mutation_algorithms(1).func = @(x, pm)(single_mutate(x, 0.9, (rand()-0.5)));
mutation_algorithms(1).pm = 0.9;
mutation_algorithms(2).name = 'non uniform universal_mutate, 0.01 per allel';
mutation_algorithms(2).func = @(x, pm)(universal_mutate(x, pm, 0.5));
mutation_algorithms(2).pm = 0.01;
mutation_algorithms(3).name = 'universal_mutate, 0.01 per allel';
mutation_algorithms(3).func = @(x, pm)(universal_mutate(x, 0.01, 0.5));
mutation_algorithms(3).pm = 0.01;
mutation_algorithms(4).name = 'non uniform single mutation 90% of individuals';
mutation_algorithms(4).func = @(x, pm)(single_mutate(x, pm, (rand()-0.5)));
mutation_algorithms(4).pm = 0.9;


N = 160;
G = 0.6;
replace_algorithm = replace_algorithms(1).func;
selection_algorithm = selection_algorithms(1).func;
selection_algorithm_2 = selection_algorithms(2).func;
cross_algorithm = cross_algorithms(1).func;
mutation_algorithm = mutation_algorithms(1);

fitness_100 = fitness_limit(10000);
generations_200 = generation_limit(200);
% Cut if reaches 0.0001 error or at 200 generations
cut_condition = @(x, y)(fitness_100(x, y) || generations_200(x, y));

initial_population = get_random_population(N);

params = struct(...
    'N', N, ...
    'G', G, ...
    'replace_algorithm', generate_replace_algorithm(replace_algorithm), ...
    'selection_algorithm', selection_algorithm, ...
    'selection_algorithm_2', selection_algorithm_2, ...
    'cross_algorithm', cross_algorithm, ...
    'mutate_algorithm', mutation_algorithm.func, ...
    'backpropagate_probablility', 0.05, ...
    'done', cut_condition, ...
    'use_first_gen', true, ...
    'first_generation', initial_population.p, ...
    'debug', true, ...
    'plotdebug', true, ...
    'mutate_cycle', 1, ...
    'c', 0.0015, ...
    'pm', mutation_algorithm.pm ...
);


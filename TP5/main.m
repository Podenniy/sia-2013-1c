function main()

  s = RandStream('mcg16807','Seed',0);
  RandStream.setGlobalStream(s);

  selection_algorithm = @elite;
  cross_algorithm = @crossover;
  mutate_algorithm = @single_mutate;
  
  params = struct(...
    'N', 10, ...
    'selection_algorithm', @elite, ...
    'selection_algorithm', @elite, ...
    'cross_algorithm', @crossover, ...
    'mutate_algorithm', @single_mutate, ...
    'done', @(x)(x.g > 4) ...                 % 4 generaciones
  );

  run_genetic_algorithm(params);
  
end
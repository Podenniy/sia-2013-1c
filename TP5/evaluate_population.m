function state = evaluate_population(state)

  fitnesses = zeros(state.N, 1);
  for i=1:state.N
    fitnesses(i) = state.p(i).i.f;
  end
  
  state.f_avg = mean(fitnesses);
  state.f_90th = prctile(fitnesses, 90);
  state.f_95th = prctile(fitnesses, 95);
  state.f_min = min(fitnesses);
  state.f_max = max(fitnesses);
  state.std = std(fitnesses);
end
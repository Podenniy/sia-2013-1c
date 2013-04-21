
load('TimeSerie_G1.mat');
dataset_3 = [];
x = (x + 4) ./ 8;
for i=1:800
  dataset_3 = [dataset_3, x(i:i+2)'];
end
expected_3 = x(4:803);

W = learn(dataset_3, expected_3, get_random_w([3 6 3 1], 0.05), 0.5, @sigmod, @sigmod_derivative, 0.05, 0.05)

set_test_3 = [];
for i=801:997
  set_test_3 = [set_test_3, x(i:i+2)'];
end
results_test_3 = x(804:1000);

neuron_results_3 = []

for i=1:size(set_test_3, 2)
  y = run_neural_network(W, set_test_3(:,i), @sigmod);
  y = y.V.(lvl(size(fieldnames(y.V), 1)));
  neuron_results_3 = [neuron_results_3, y];
end
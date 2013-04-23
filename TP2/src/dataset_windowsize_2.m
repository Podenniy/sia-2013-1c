
load('TimeSerie_G1.mat');
dataset_2 = [];
x = x ./ 4;
for i=1:800
  dataset_2 = [dataset_2, x(i:i+1)'];
end
expected_2 = x(3:802);

cap = 0.6;
error_cap = 0.05;
learn(dataset_2, expected_2, get_random_w([2 3 2 1], cap), 0.2, @tanh, @(x)(sech(x).^2), cap, 0.3, error_cap)

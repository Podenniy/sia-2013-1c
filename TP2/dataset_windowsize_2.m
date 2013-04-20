
load('TimeSerie_G1.mat');
dataset_2 = [];
x = (x + 4) ./ 8;
for i=1:800
  dataset_2 = [dataset_2, x(i:i+1)'];
end
expected_2 = x(3:802);

learn(dataset_2, expected_2, get_random_w([2 3 2 1], 0.05), 0.5, @sigmod, @sigmod_derivative, 0.05)
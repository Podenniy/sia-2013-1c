% 
% load('TimeSerie_G1.mat');
% dataset_2 = [];
% x = x ./ 4;
% 
% inputs = 2;
% 
% for i=1:800
%   dataset_2 = [dataset_2, x(i:i+inputs - 1)'];
% end
% expected_2 = x(inputs + 1:size(dataset_2, 2) + inputs);
% 
% cap = 0.6;
% error_cap = 0.005;
% W = learn(dataset_2, expected_2, get_random_w([inputs 4 2 1], cap), 0.2, @tanh, @(x)(sech(x).^2), 0.3, error_cap);
% 

load('TimeSerie_G1.mat');
test_set = [];
x = x ./ 4;

inputs = 2;
start = 800;

for i=start:size(x, 2) - inputs - 1
  test_set = [test_set, x(i:i+inputs-1)'];
end
expected_values = x(start + inputs:start + inputs + size(test_set, 2));

W = {};

W.A = [ -2.7728    2.7986   -1.6103 ;
   -1.0610    0.8209    0.0673 ;
   -0.6262    0.9361    0.1054 ;
    3.0848   -3.0441   -0.7314 ];

W.B = [ 1.2904    0.7538    0.6682   -2.8015    0.1213 ;
   -2.4279   -0.5831   -0.4454    1.0014    0.4304 ];

W.C = [ -0.8427   -0.9102    0.2307 ];
   
name = lvl(size(fieldnames(W), 1) + 1);
err = [];
for i = 1 : size(test_set, 2)
  out = run_neural_network(W, test_set(:,i), @tanh);
  err = [err norm(out.V.(name) - expected_values(i))];
end

figure(1); plot(err);
disp(mean(err));

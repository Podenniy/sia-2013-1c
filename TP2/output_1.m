% Run with
% load('TimeSerie_G1.mat');
% dataset_2 = [];
% x = x ./ 4;
% for i=1:800
%   dataset_2 = [dataset_2, x(i:i+1)'];
% end
% expected_2 = x(3:802);
%
% cap = 0.6;
% learn(dataset_2, expected_2, get_random_w([2 5 4 1], cap), 0.2, @tanh, @(x)(sech(x).^2), cap, 0.3)

load('TimeSerie_G1.mat');
test_set = [];
x = x ./ 4;
for i=1:size(x, 2) - 3
  test_set = [test_set, x(i:i+1)'];
end
expected_values = x(3:size(x, 2));

W = {};

W.A = [-3.9923    3.9946   -0.5335 ; 
    1.6285   -1.6067   -2.5701 ; 
   -3.1214    3.1278    2.6785 ; 
    3.1154   -3.1163    3.6127 ;
    1.0681   -1.0330   -1.5696];

W.B = [ -0.1662   -2.2192   -2.7086   -2.2610   -1.2674    0.0400 ; 
   -1.5342   -0.1475   -2.9563    0.6834    0.1989    0.6180 ; 
   -0.2897    0.6571   -3.2261   -3.8245    0.2762    1.3281 ;
   -1.7331    0.0998   -0.9747    3.4806    0.6264    0.1162];

W.C = [ -1.2167    2.0684   -1.0270   -2.0661    0.2933 ];

name = lvl(size(fieldnames(W), 1) + 1);
err = [];
for i = 1 : size(test_set, 2)
  out = run_neural_network(W, test_set(:,i), @tanh);
  err = [err norm(out.V.(name) - expected_values(i))];
end

figure(1); plot(err);


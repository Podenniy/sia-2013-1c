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
% error_cap = 0.025;
% W = learn(dataset_2, expected_2, get_random_w([inputs 10 6 1], cap), 0.2, @tanh, @(x)(sech(x).^2), 0.3, error_cap);
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

W.A = [ -0.6720    0.8822    1.2405 ;
    0.4559   -0.3299    0.0374 ; 
    0.2844   -0.2541   -0.0534 ; 
   -1.1475    1.2177   -0.2747 ;
    0.7198   -0.6058   -0.7921 ; 
    3.5434   -3.5751    4.0387 ;
    3.1925   -3.1373   -1.7819 ;
   -2.0430    1.9770   -0.1408 ;
    1.8911   -1.7823   -2.9171 ;
   -3.1466    3.1247   -0.7052 ];

W.B = [ 0.5594   -0.2953   -0.1313    1.1419   -0.5151    1.9164   -1.7771    1.1325   -0.9911   -0.1636    0.8009 ;
    0.8232   -0.6858   -0.2102   -0.2062   -0.6157   -1.9039    0.2033   -1.4238   -2.0036   -1.3369   -0.2314 ;
    0.6154   -0.2198   -0.1294    0.5224   -0.7784   -3.9411   -0.3950    1.1893   -0.5695    0.9605   -1.0752 ;
    0.8577   -0.1945   -0.3765   -0.3429   -0.8218   -0.6506    0.3171   -0.8697   -1.3262   -0.7107   -0.0755 ;
   -0.1135   -0.1525   -0.0656    0.1481   -0.0648   -0.0553    1.2281    0.1709    0.2805   -1.8271    0.0128 ;
   -0.0405   -0.2746   -0.2946    0.2234   -0.0274   -3.2623    1.3062   -1.0950    0.5842    0.1779   -0.7387 ];

W.C = [ 1.7049   -0.9491    1.1313   -0.4290    1.8917   -1.2607   -0.7651 ];
    
    
name = lvl(size(fieldnames(W), 1) + 1);
err = [];
for i = 1 : size(test_set, 2)
  out = run_neural_network(W, test_set(:,i), @tanh);
  err = [err norm(out.V.(name) - expected_values(i))];
end

figure(1); plot(err);
disp(mean(err));

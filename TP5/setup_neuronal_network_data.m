function setup_neuronal_network_data()
  global dataset;
  global expected;
  global test_set;
  global test_results;
  window_size = 2;

  load('TimeSerie_G1.mat');
  x = x ./ 4;
  dataset = zeros(window_size, 800);
  for i=1:800
    dataset(:,i) = x(i:i+window_size-1)';
  end
  
  expected = x(window_size+1:800+window_size);
  test_set = zeros(window_size, 200-window_size);
  for i=801:1000-window_size
    test_set(:,i-800) = x(i:i+window_size-1)';
  end
  test_results = x(801+window_size:1000);
end
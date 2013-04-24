
sizes = [];
plots = struct();
for i = 1:4
  t = load(['steps_' num2str(i) '_data_result.mat']);
  sizes= [sizes t.data.iter];
  plots.(char('@' + i)) = t.data.mean_errors;
end

for i =1:max(sizes)
  
    pr = '';
  for j = 1:4
    if i <= size(plots.(char('@'+j)), 1)
      pr = [pr ',' num2str(plots.(char('@'+j))(i))];
    else
      pr = [pr ','];
    end
  end
    disp(pr);
end
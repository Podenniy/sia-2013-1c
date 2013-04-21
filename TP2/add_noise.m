function W = add_noise(W, noise_factor)

  for i = 1 : size(fieldnames(W), 1)
    name = lvl(i);
    w = W.(name);
    t = rand(size(w)) ./ mean(mean(abs(w))) .* noise_factor;
    w = w + t;
  end  
end
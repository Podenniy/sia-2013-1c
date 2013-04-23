function W = add_noise(W, noise_factor)

  names = get_lvls(W);
  for i = 1 : size(names, 1)
    name = names(i);
    w = W.(name);
    t = rand(size(w)) ./ mean(mean(abs(w))) .* noise_factor;
    w = w + t;
  end  
end
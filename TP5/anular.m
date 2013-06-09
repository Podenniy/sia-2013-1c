function [u, v] = anular(i1, i2, L)

  N = size(i1.allels, 1);

  t1 = randi([1,N]);
  t2 = t1+L;
  if t2 > N
    c = t1;
    t1 = t2-N;
    t2 = c;
  end

  allels1 = [i1.allels(   1:t1);...
             i2.allels(t1+1:t2);...
             i1.allels(t2+1:N )];

  allels2 = [i2.allels(   1:t1);...
             i1.allels(t1+1:t2);...
             i2.allels(t2+1:N )];

  i1.allels = allels1;
  i2.allels = allels2;
  u = unflatten(i1);
  v = unflatten(i2);

end

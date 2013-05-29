function t = get_default_parameter(S, name, default)

  if isfield(S, name)
    t = S.(name);
  else
    t = default;
  end
end
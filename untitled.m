function pts = logspacepts(min,max,N,switch)

if switch
    pts = unique(floor(logspace(log10(min),log10(max),N)));
end
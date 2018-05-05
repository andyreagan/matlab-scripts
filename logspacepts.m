function pts = spacepts(min,max,N,boolswitch)
% LOGSPACEPTS spaces points evenly in log space, nicely
%   Inputs are:
%       min,max: range of points
%       N: number of points, max (there will be less)
%       boolswitch: if to logspace or not
%
%   Returns:
%       pts: the log (or not) spaces points


if boolswitch
    pts = unique(floor(logspace(log10(min),log10(max),N)));
else
    pts = unique(floor(linspace(min,max,N)));
end
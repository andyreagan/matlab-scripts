function psprint(filename)
% psprint('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% see also psprintc
filenameps = sprintf('%s.ps',filename);
disp(sprintf('printing to %s.ps',filename));
print(filenameps,'-deps2');
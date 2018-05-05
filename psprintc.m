function psprintc(filename)
% psprintc('filename')
% (colour)
% prints current figure with 
% the following flags
% -depsc2
% .ps will be appended
%
% see also psprint
filenameps = sprintf('%s.ps',filename);
disp(sprintf('printing (colour) to %s.ps',filename));
print(filenameps,'-depsc2');
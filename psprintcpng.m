function psprintcpng(filename)
% psprintcpng('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf and prints to png
%
% see also psprintc
disp(sprintf('printing to\n%s.ps (colour)\n',filename));
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-depsc2');

disp(sprintf('converting to\n%s.png\n',filename));
pngcommand = sprintf('convert %s.ps %s.png',filename,filename);
system(pngcommand);

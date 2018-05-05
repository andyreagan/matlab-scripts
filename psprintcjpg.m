function psprintcjpg(filename)
% psprintcjpg('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf and prints to jpg
%
% see also psprintc
disp(sprintf('printing to\n%s.ps (colour)\n',filename));
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-depsc2');

disp(sprintf('converting to\n%s.jpg\n',filename));
jpgcommand = sprintf('convert %s.ps %s.jpg',filename,filename);
system(jpgcommand);

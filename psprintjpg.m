function psprintjpg(filename)
% psprintjpg('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf and prints to jpg
%
% see also psprintc
disp(sprintf('printing to %s.ps',filename));
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-deps2');

disp(sprintf('converting to %s.jpg',filename));
jpgcommand = sprintf('convert %s.pdf %s.jpg',filename,filename);
system(jpgcommand);

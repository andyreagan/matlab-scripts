function psprintpdf_jpg(filename)
% psprintpdf_jpg('filename')
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

disp(sprintf('converting to %s.pdf',filename));
pdfcommand = sprintf('epstopdf %s',filenameps);
system(pdfcommand);

disp(sprintf('printing to %s.jpg',filename));
filenamejpg = sprintf('%s.jpg',filename);
print(filenamejpg,'-djpeg');

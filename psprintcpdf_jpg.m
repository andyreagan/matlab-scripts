function psprintcpdf_jpg(filename)
% psprintcpdf_jpg('filename')
% prints current figure with 
% the following flags
% -depsc2
% .ps will be appended
% color
%
% also converts to pdf and prints to jpg
%
% see also psprintc
disp(sprintf('printing to %s.ps',filename));
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-depsc2');

disp(sprintf('converting to %s.pdf',filename));
pdfcommand = sprintf('epstopdf %s',filenameps);
system(pdfcommand);

disp(sprintf('converting to %s.jpg',filename));
jpgcommand = sprintf('convert %s.pdf %s.jpg',filename,filename);
system(jpgcommand);


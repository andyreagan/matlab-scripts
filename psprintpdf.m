function psprintpdf(filename)
% psprintpdf('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf
%
% see also psprintc
filenameps = sprintf('%s.ps',filename);
disp(sprintf('printing to %s.ps',filename));
print(filenameps,'-deps2');
disp(sprintf('converting to %s.pdf',filename));
pdfcommand = sprintf('epstopdf %s',filenameps);
system(pdfcommand);

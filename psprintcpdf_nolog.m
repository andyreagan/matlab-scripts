function psprintcpdf_nolog(filename)
% psprintcpdf_nolog('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf
%
% see also psprintc
filenameps = sprintf('%s.ps',filename);
filenamepdf = sprintf('%s.pdf',filename);
fprintf(1,'printing (colour) to:\n%s.ps\n',filename);
print(filenameps,'-depsc2');
fprintf(1,'converting to:\n%s.pdf\n',filename);
pdfcommand = sprintf('epstopdf %s',filenameps);
system(pdfcommand);
%% disp('deleting postscript...');
%% rmcommand = sprintf('\\rm %s',filenameps);
%% system(rmcommand);


function psprintcpdf_rotate90(filename)
% psprintcpdf_rotate90('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
%
% also converts to pdf and rotates
%
% see also psprintc
filenameps = sprintf('%s.ps',filename);
filenamepdf = sprintf('%s.pdf',filename);
disp(sprintf('printing (colour) to %s.ps',filename));
print(filenameps,'-depsc2');
disp(sprintf('converting to %s.pdf and rotating 90 degrees...', ...
             filename));
pdfcommand = sprintf('gs -sDEVICE=pdfwrite -sOutputFile="%s" -dNOPAUSE -dEPSCrop -c "<</Orientation 3>> setpagedevice" -f "%s" -c quit',filenamepdf,filenameps);
system(pdfcommand);

%% disp('deleting postscript...');
%% rmcommand = sprintf('\\rm %s',filenameps);
%% system(rmcommand);

function psprintcpdf(filename)
% psprintcpdf('filename')
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
disp('deleting postscript...');
rmcommand = sprintf('\\rm %s',filenameps);
system(rmcommand);

%% write to log
homedir = getenv('HOME');
cdir = pwd;
timestamp = datevec(now);

logfile = sprintf('%s/work/log/figures/%d',homedir,timestamp(1));
fid = fopen(logfile,'a');

command = sprintf('ls -l %s| awk ''{print $5}''',filenamepdf);
[status,bytes] = system(command);
%% remove carriage return
bytes = bytes(1:end-1);

fprintf(fid,'%d %02d %02d %02d %02d %g %s %s/%s\n',timestamp(1),timestamp(2),timestamp(3),timestamp(4),timestamp(5),timestamp(6),bytes,cdir,filenamepdf);

fclose(fid);

fprintf(1,'figure data logged.\n');

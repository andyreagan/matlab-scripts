function psprint(filename)
% psprint('filename')
% prints current figure with 
% the following flags
% -deps2
% .ps will be appended
% 600 dpi
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-deps2','-r600');
function figurearchivify(figname)
%% figurearchivify(figname)
system('mkdir -p archive');
sprintf('figure creation archiving is on ...\n');
tmpcommand = sprintf('cp %s.pdf archive/%s-%s.pdf;',figname,figname,datestr(now,'yyyy-mm-dd-HH-MM-SS'));
fprintf(1,'archiving figure ...\n');
system(tmpcommand);

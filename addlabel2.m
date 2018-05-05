function h = addlabel(label,labelXcoord,labelYcoord,fontsize)
%% h = addlabel(label,labelXcoord,labelYcoord,fontsize)
%%
%% add label to current plot
%% (keep this script in local figure creation directory)

labelbgcolor = 0.95;
h = text(labelXcoord,labelYcoord,label,'Fontsize',fontsize,'fontname','helvetica',...
         'units','normalized');
set(h,'backgroundcolor',labelbgcolor*[1 1 1]);
%% set(h,'backgroundcolor','none');
set(h,'edgecolor',[0 0 0]);
set(h,'linestyle','-');
set(h,'linewidth',1);
set(h,'margin',1);

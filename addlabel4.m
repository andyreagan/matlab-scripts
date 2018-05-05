function h = addlabel4(alphaindex,labelXcoord,labelYcoord,fontsize)
%% h = addlabel3(alphaindex,labelXcoord,labelYcoord,fontsize)
%%
%% add label to current plot
%% alphaindex points to capital letter 
%% 1 -> A, 2 -> B, ...  
%% obviously works well up to Z only.
%% (keep this script in local figure creation directory)

label = sprintf(' %s ',char('A'+alphaindex-1));
labelbgcolor = 0.85;
h = text(labelXcoord,labelYcoord,label,'Fontsize',fontsize,'fontname','helvetica',...
         'units','normalized');
set(h,'backgroundcolor',labelbgcolor*[1 1 1]);
%% set(h,'backgroundcolor','none');
set(h,'edgecolor',[0 0 0]);
set(h,'linestyle','-');
set(h,'linewidth',0.5);
set(h,'margin',0.5);

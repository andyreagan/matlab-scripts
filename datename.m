function datename(xpos,ypos)
% datename(xpos,ypos)
% plot a date and name stamp on current graph
% to be used mainly in fig*.m printing m-files
% xpos, ypos are in units of current plot
% (0,0) = bottom lefthand corner
dn = ['[',date,' peter dodds]'];
text(xpos,ypos,dn,'fontsize',10);

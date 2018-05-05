function datenamer(xpos,ypos,rot)
% datenamer(xpos,ypos,rot)
% plot a date and name stamp on current graph
% to be used mainly in fig*.m printing m-files
% xpos, ypos are in units of current plot
% rot specifies the rotation in degrees
% (0,0) = bottom lefthand corner
dn = sprintf('\\copyright Peter Sheridan Dodds %s',datestr(now,'yyyy-mm-dd HH:MM:SS'));

tmph = text(xpos,ypos,dn,'fontsize',8,...
            'color',0.7*[1 1 1],'horizontalalignment','right',...
            'rotation',rot,'fontname','helvetica');

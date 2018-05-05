function addlabel3(labelstring,left,bottom,fontsize)
% FUNCTION ADDLABEL3
%
% Plot the given string with a grey background and black border on the
% current figure.
%
%   INPUTS:
%       labelstring: string for the text
%       the others are also obvious

% just this one command:
text(left,bottom,labelstring,'fontsize',fontsize,'units','normalized','BackgroundColor',.7*[1 1 1],'EdgeColor','k')
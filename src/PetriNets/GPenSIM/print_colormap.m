function [] = print_colormap(Sim_Results, place)
% [] = print_colormap(pn, Sim_Results, place)
% 
% Name:	print_colormap
% Purpose:	To print colors of the tokens
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
%                   {set_of_place_names}
% Out parameters:	None
% Uses:	print_colormap_for_place 
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   results = gpensim(pn, dynamicpart);
%   print_colormap(results, {'pNUM1','pADDED', 'pRESULT'}); 
% 

disp('');
disp('Printing Colormap ...');

if (nargin==2),   % specific place(s) is given
    if ischar(place), % only a specific place is given
        print_colormap_for_place (Sim_Results, place);
    else
        for i=1:length(place), % set of places are given
            print_colormap_for_place (Sim_Results, place{i});
        end;
    end;
    return;
end;

% no specific place(s) are given; print all colors for all places
color_map = Sim_Results.color_map;
length_of_colormap = length(color_map);

% print color_map    
for i=1:length_of_colormap,
    ttime = color_map(i).time;
    pi = color_map(i).place;
    place_name = Sim_Results.Place_Names(pi, :);
    colors = color_map(i).color; 
    disp(['Time:',num2str(ttime),' Place:', place_name,...
        ' Colors:', colors]);
end;


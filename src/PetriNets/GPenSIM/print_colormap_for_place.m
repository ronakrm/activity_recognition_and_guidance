function [] = print_colormap_for_place (Sim_Results, place)
% [] = print_colormap_for_place (Sim_Results, place)

Place_Names = Sim_Results.Place_Names;
Ps = size(Place_Names, 1);
pi = 0; found = 0;

while and(~(found), lt(pi, Ps)),        
    pi = pi + 1;
    found = strcmp(Place_Names(pi,:), good_name(place));
end;

if ~found, disp('Wrong place name'); return;end;

disp(' '); disp(' ');
disp(['Color Map for place: ', place]);
disp(' ');

% extract color_map for given place
% disp(['extract color_map for given place....']);
color_map = Sim_Results.color_map;
new_CM = [];
for i=1:length(color_map),
    cm = color_map(i);
    if isequal(pi, color_map(i).place),
        new_CM = [new_CM cm];
    end;
end;

% print the extracted color_map
for i=1:length(new_CM),
     if not(isnan(new_CM(i).time)),
        disp(['Time: ',num2str(new_CM(i).time), ' Color: ',...
            new_CM(i).color]);
     end;
end;    

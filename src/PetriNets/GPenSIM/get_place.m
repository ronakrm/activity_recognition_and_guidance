function px = get_place(PN, place_name)
%% [px] = get_place(PN, 'place_name')
%%
%% E.g. p1 = place(PN, 'buffer_1');
%%
%% This function extracts place from Petri net structure.
%%
%% Define variables: 
%% Inputs: 	PN: the Petri net structure 
%%          place_name: a name (string) identifying the place
%%
%% Output:  place 
%% 
%% Functions called : (none)

%% RD 05.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global_places = PN.global_places;
p_index = search_names(place_name, global_places);
if (p_index),
    px = global_places(p_index);
else
    px = [];
end;


function p_index = is_place(PN, place_name)
%% [p_index] = is_place(PN, 'place_name')
%%
%% E.g. pi = is_place(PN, 'buffer_1');
%%
%% This function returns the position of place in the 
%% Petri net structure. If the place is not found in
%% the Petri net, zero is returned. 
%%
%% Define variables: 
%% Inputs:  PN: the Petri net structure 
%%          place_name: a name (string) identifying the place
%%
%% Output:  index,  (1-number_of_places) if found, 
%%                  0 therwise  
%%
%% Functions called : (none)

%% RD 10.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global_places = PN.global_places;
p_index = search_names(place_name, global_places);


function [global_places] = build_places(set_of_places)
%% [global_places] = build_places(set_of_places)
%%

%%% treating set_of_places
no_of_places = length(set_of_places); %number of elements to be extracted
%allocate empty matrix for accomodating elements extracted
global_places = []; 
%% extracting elements
for i=1:no_of_places,
    curr_place_name = set_of_places{i};
    curr_place = place(curr_place_name);  % create a place sturcture
    global_places = [global_places curr_place];
end;

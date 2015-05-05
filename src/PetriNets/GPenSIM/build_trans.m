function [global_transitions] = build_trans(set_of_trans)
%% [global_transitions] = build_trans(set_of_trans)

%%% treating set_of_transitions
no_of_trans = length(set_of_trans); %number of elements to be extracted
%allocate empty matrix for accomodating elements extracted
global_transitions = []; 
%% extracting elements
for i=1:no_of_trans,
    curr_trans_name = set_of_trans{i};
    curr_trans = trans(curr_trans_name);   % create trans structure
    global_transitions = [global_transitions curr_trans];
end;

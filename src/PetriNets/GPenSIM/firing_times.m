function [pn] = firing_times(pn, ftimes) % firing times
% function [pn] = firing_times(pn, ftimes) % firing times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts a group of elements from a given inputs of
% global_elements and elements. The resulting output is an element matrix.
% function elements_m = elements_matrix(pn.global_elements, elements)
% Inputs:
%       -global elements
%      - elements
% Output: elemets matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

no_of_trans = length(ftimes)/2; %number of elements to be extracted

% extracting elements
% check whether the current elements is a member of global_elements
% sett in extracted element in the allocted matrix

for i=1:no_of_trans,
    curr_trans_name = ftimes{2*i -1};
    trans_nr = search_names(curr_trans_name, pn.global_transitions); 
    if (trans_nr == 0), %wrong transition name
        error([curr_trans_name, ': No such transition name']);
    end;
        
    % assign firing time to transitions
    ft = ftimes{2*i};
    if ischar (ft),  %firing time is a string; e.g. 'unifrnd(1,1)', 
        pn.global_transitions(trans_nr).firing_time = ft;  
        pn.Set_of_Firing_Times(trans_nr) = NaN;
        
    elseif eq(length(ft), 3),  %firing time is vector [hh mm ss]
        pn.HH_MM_SS = 1; % set Hour-Min-Sec flag
        
        ft2 = ft(3) + (60 * ft(2)) + (60 * 60 * ft(1)); % convert to seconds
        pn.global_transitions(trans_nr).firing_time = ft2;  
        pn.Set_of_Firing_Times(trans_nr) = ft2;
    else   % firing time is in seconds 
        pn.global_transitions(trans_nr).firing_time = ft;  
        pn.Set_of_Firing_Times(trans_nr) = ft;
    end;
end;

% now set the delta_T 
if eq(pn.delta_T,0),
    % IMPORTANT: string firing times are not counted (NaN)
    min_FT = min(pn.Set_of_Firing_Times);
    if or(isnan(min_FT), eq(min_FT, 0)),
        delta_T = 0.25;
    else
        delta_T = 0.25 * min_FT;
    end;
    pn.delta_T = delta_T;
end;



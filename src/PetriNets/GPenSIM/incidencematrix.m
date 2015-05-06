function [A] = incidencematrix(PN)
% [A] = incidencematrix(PN)
% This function computes the incidence matrix of a Petri net
% Use: [A] = incidence_matrix(PN)
% Inputs:
%       PN - structure for Petri net
%       
% Outputs: Incidence matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
no_transitions = length(PN.global_transitions);
no_places = length(PN.global_places);
no_arcs = length(PN.global_arcs);

% declare empty incidence matrix  with 
%       row    == no of transitions, and 
%       column == twice the number of places
A = zeros(no_transitions, 2*no_places);

for i=1:no_arcs, %number of transition
    curr_arc = PN.global_arcs(i);
    from_element = curr_arc.from;
    to_element = curr_arc.to;
    w = curr_arc.weight;
    if strcmp(from_element.type, 'place'), % arc from input place to trans
        p = search_names(from_element.name, PN.global_places);
        t = search_names(to_element.name, PN.global_transitions);
        A(t, p) = w; %fill in the incidence_matrix
    else % arc from transition to ouptput place
        p = search_names(to_element.name, PN.global_places);
        t = search_names(from_element.name, PN.global_transitions);
        A(t, p+no_places) = w; %fill in the incidence_matrix
    end;
end;


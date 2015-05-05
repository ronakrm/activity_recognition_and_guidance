function [set_of_enabled_transitions] = any_enabled_transitions(pn) 
% [set_of_enabled_transitions] = any_enabled_transitions(pn) 
%
% Name:	any_enabled_transitions 
% Purpose:	This function checks whether there are any enabled transitions.
% Checking is done by one transition at a time. 
% Input parameters:	pn: petri net run-time structure
% Out parameters:	set_of_enabled_transitions (set or zeros and ones)
% Uses: enabled_transition
% Used by: ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = length(pn.global_transitions); % number of transitions
set_of_enabled_transitions = zeros(1,Ts); % initially

for i=1:Ts,
    set_of_enabled_transitions (i) = enabled_transition(i, pn);
end;

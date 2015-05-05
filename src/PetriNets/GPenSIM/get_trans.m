function tx = get_trans(PN, trans_name)
% [tx] = get_trans(PN, 'trans_name')
%
% E.g. t1 = get_trans(PN, 'Robot_1');
%
% This function extracts a transition from Petri net structure.
%
% Define variables: 
% Inputs:  PN: the Petri net structure 
%          trans_name: a name (string) identifying the transition
%
% Output:  transition 
% 
% Functions called : (none)

global_transitions = PN.global_transitions;
t_index = search_names(trans_name, global_transitions);
if (t_index),
    tx = global_transitions(t_index);
else
    tx = [];
end;


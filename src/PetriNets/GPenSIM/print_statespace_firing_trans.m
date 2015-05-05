function [] = print_statespace_firing_trans(firing_trans, ...
    checking_time, Transition_Names, HH_MM_SS)
% function [] = print_statespace_firing_trans(firing_trans, ...
%    checking_time, Transition_Names, HH_MM_SS)

if (HH_MM_SS),
    disp(['At time: ', string_HH_MM_SS(checking_time)]);
else
    disp(['At time: ', num2str(checking_time)]);
end;
disp('  Firing transtions are: ');
ft_index = find(firing_trans);
Set_fev = [];

for k=1:length(ft_index),
    ftn = ft_index(k);
    firing_event_name = Transition_Names(ftn, :);
    % firing_event_name = pn.global_transitions(ftn).name;
    Set_fev = [Set_fev, ' ',firing_event_name]; 
end;

disp(Set_fev);


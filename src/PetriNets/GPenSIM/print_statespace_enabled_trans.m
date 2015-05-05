function [] = print_statespace_enabled_trans(enabled_trans, ...
        checking_time, Transition_Names, HH_MM_SS)
% function[]=print_statespace_enabled_trans(enabled_trans,checking_time,pn);

% row - 2: Enabled Transitions
if (HH_MM_SS),
    disp(['At time: ', string_HH_MM_SS(checking_time)]);
else
    disp(['At time: ', num2str(checking_time)]); 
end;
disp('  Enabled transtions are: ');
et_index = find(enabled_trans);

Set_fev = [];
for j=1:length(et_index),
    etn = et_index(j);
    enabled_event_name = Transition_Names(etn, :); 
    Set_fev = [Set_fev, ' ',enabled_event_name]; 
end;

disp(Set_fev);    

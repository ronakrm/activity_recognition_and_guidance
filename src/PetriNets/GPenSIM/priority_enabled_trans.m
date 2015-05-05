function [ordered_enabledTs] = priority_enabled_trans(pn, enabledTrans)
% function [ordered_enabledTs ] = priority_enabled_trans(pn, enabledTrans)
%
% This function will sort out enabled transitions in 
% decending order of priority 

Ts = pn.No_of_transitions;

PList = pn.priority_list;
[sorted_PList, t_index] = sort(PList, 'descend');

ordered_enabledTs = [];
for i=1:Ts,
    if ismember(t_index(i), enabledTrans),
        ordered_enabledTs = [ordered_enabledTs t_index(i)];
    end;
end;

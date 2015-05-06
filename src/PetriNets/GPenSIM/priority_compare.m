function [HEL] = priority_compare(PN, trans1, trans2) 
% function [HEL] = priority_compare(PN, trans1, trans2) 
%
% This function compares priority of trans1 with trans2.
%
% Inputs:   PN : PN structure
%           trans1, trans2: the transitions (Names or Numbers)
% Output:   HEL = 1  if priority of trans1 > trans2
%           HEL = 0  if priority of trans1 = trans2
%           HEL = -1 if priority of trans1 < trans2

t1 = trans1; t2 = trans2;

if ~isnumeric(t1), 
    t1 = search_names(trans1, PN.global_transitions);
    t2 = search_names(trans2, PN.global_transitions);    
    if ~and(t1, t2), 
        error(['Transition name(s) is wrong', trans1, ' or ', trans2 ]); 
    end;
end;

PList = PN.priority_list;

if gt(PList(t1), PList(t2)), 
    HEL = 1;
elseif eq(PList(t1), PList(t2)), 
    HEL = 0;
else
    HEL = -1;
end;


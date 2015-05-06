function [enabled_or_not] = is_enabled(PN, transition1)
% function [enabled_or_not] = is_enabled(PN, transition1)

%if t is name then convert into number
if ischar(transition1),
    transition1 = is_trans(PN, transition1); 
end;

enabled_or_not = PN.Enabled_Transitions(transition1);


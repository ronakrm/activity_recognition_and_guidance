function [pn, global_info] = ...
        firing_postactions(transition1, pn, global_info)
% [global_info] = firing_postactions(transition1, pn, global_info)
% (any post-actions after firing?) 
% 
% This functions checks whether user-defined (if any) 
% conditions are satisfied before firing a transition. 
% The user-defined conditions are defined in TDF 
% 
% Define variables: 
% Inputs:  transition1 : index of the transition inside PN
%		PN : the strcture for the Petri net
%
% Output: Boolean value (true/false), based on whether 
% 		user-defined conditions are met or not.
%
% Functions called: 
%         	(feval) 

if pn.POST_exist(transition1),
    tname = pn.global_transitions(transition1).name;
    funcname = [tname '_post'];
    [pn, global_info] = ...
        feval(str2func(funcname), transition1, pn, global_info);

end;

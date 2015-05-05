function [sfc, pn, new_color,override,selected_tokens,global_info] = ...
        firing_preconditions(transition1, pn, global_info)
% [sfc] = firing_preconditions(transition1, pn, global_info)
% (any pre-conditions for firing?) 
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


new_color = {};
override = 0; % by default, do not override earlier colors
selected_tokens = [];

if pn.PRE_exist(transition1),
    tname = pn.global_transitions(transition1).name;
    funcname = [tname '_pre'];
    [sfc, pn, new_color, override, selected_tokens, global_info] = ...
        feval(str2func(funcname), pn, new_color, override, ...
        selected_tokens, global_info);
    if not(iscell(new_color)), 
        new_color = {new_color}; % new colors are to be in cell format
    end;
else
    sfc=1;    % if no TDF, then always fire if enabled. 
end;

function [tx] = trans(name)
%% [tx] = trans('name', firing_time, firing_cost, firing_conditions)
%%
%% E.g.: 	t1 = trans('tRobot_1')
%%          t2 = trans('tRobot_1', 10)
%%          t3 = trans('tRobot_1', ’unifrnd(10,2)’)
%% 
%% This functions creates a transition. 
%%
%% Inputs: 	name: name (string) for identifying the transition
%%         	firing_time 
%%          times_fired
%%         	firing_cost: NOT USED
%%
%% Output   : [tx] structure for transition 
%%
%% Functions called : (none)
 
%%  RD 10. February 2006 (new)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tx.type = 'transition';
tx.name = name;
tx.firing_time = 0; % default 
tx.firing_cost = 0; % default 
tx.times_fired = 0; %number of times fired, initially is zero


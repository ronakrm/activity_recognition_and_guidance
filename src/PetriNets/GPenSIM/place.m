function [px] = place(P_name)
%% [px] = place('Place_Name')
%%
%% E.g.: 	p1 = place('pBuffer_1');
%%
%% This function creates a place.
%%
%% Define variables: 
%% Inputs: 	place_name: a name (string) identifying the place
%%		max_capacity: (optional/not used)
%%
%% Output:  a structure for place 
%% 
%% Functions called : (none)

%% RD 10. February 2006 (Comments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
px.type = 'place';
px.name = P_name;
px.tokens = 0; %initially
px.max_capacity = inf; % NOT USED in version 3.1

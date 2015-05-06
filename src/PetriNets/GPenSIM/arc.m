function [ax] = arc(source, destination, arc_weight, arc_name)
%% [ax] = arc(source, destination, arc_weight, 'arc_name')
%% Name:	arc
%% Purpose:	To create an arc structure. An arc structure has the following 5 elements: 
%%  1. type = ‘arc’,  2. from (source name), 3. to (destination name), 
%%  4. weight (integer), and 5. name of the arc. 
%% Note: the last element, name of the arc is not used. May be removed later.
%% Input parameters:	
%%  Source: name of place/transiton the arc is originating from
%%  Destination: name of place/transiton to which the arc is pointing to. 
%%  arc_weight: weight of the arc
%%  arc_name: (not used)
%%
%% Out parameters:	ax: the structure of the arc containing 
%%
%% Uses:	None
%% Used by:	?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax.type = 'arc';
ax.from = source;
ax.to = destination;
ax.weight = 1; % default
ax.name = strcat('Arc.',  num2str(round(rand*500))); % random name

if nargin > 2,
    ax.weight = arc_weight; % user-given arc weight
end;

if nargin > 3,
    ax.name = arc_name; % arc name
end;
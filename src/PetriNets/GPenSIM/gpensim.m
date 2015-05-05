function [sim_results, global_info, pn] = gpensim (png, ...
                            dynamicpart, global_info)
% [Sim_results,global_info,pn] = gpensim (png, dynamicpart,global_info)
% 
% Name:	fpensim
% Purpose:	To run simulations and output simulation results
%           (When the results are returned, they can be also analyzed 
%           with tools like print_statespace, plotp, extract, etc.)  
% Input parameters:	Static Petri net structure (output from ‘petrinetgraph’)
%                   initial dynamics
%                   global_info
% Out parameters:	Simulation results
%                   global info
% Uses:	gpensim_ver, initial_markings, init_token_bank, 
%       firing_times, state_space,  
%       timed_gpensim
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   [simualtion_Results, global_info] = pensim(png, dyn, global_info);
%   print_statespace(simualtion_Results);
% 

% if no inputs, then print the version number 
if (nargin==0), gpensim_ver; return; end;

% process global options
if (nargin==2), 
    global_info = struct([]); 
end;
png = process_global_options(png, global_info); 

% process initial makrings
if not(isempty(dynamicpart)),
    imarkings = dynamicpart.initial_markings;
    [X, png] = intial_marking(png, imarkings); % intial marking
    png.X = X;  % current state element is established in PN structure
    png = init_token_bank(png);    
else
    error('gpensim: dynamic part is empty');
end;

% process firing times
png.Set_of_Firing_Times = zeros(1, png.No_of_transitions); 
if (isfield(dynamicpart, 'firing_times')), 
    png = firing_times(png, dynamicpart.firing_times);
end;

% process resources
if (isfield(dynamicpart, 'resources')), 
    png = init_resources(png, dynamicpart.resources);
else
    png.resources = [];
end;

% check whether Preconditions and Postactions are available
png = filecheck_pre_post(png);  % if exist, set the flag for TDF  

% run the simulation
[sim_results, global_info, pn] = timed_pensim(png, global_info);

% the resulting state space
sim_results.State_Diagram = state_space(sim_results);


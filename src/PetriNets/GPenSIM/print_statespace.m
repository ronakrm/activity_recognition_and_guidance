function [] = print_statespace (sim_results)  
% function [] = print_statespace(sim_results)  
%
% Name:	print_statespace
% Purpose:	To print simulation results
% Input parameters:	Simulation Results (a structure output by ‘gpensim’)
% Out parameters:	-
% Uses:	print_markings, 
%       print_statespace_enabled_trans, 
%       print_statespace_firing_trans
%       print_statespace_state
% Used by:	[main simulation file]
% NOTE:	Not for use with simulations using stochastic timer
% Example:	
% % in main simulation file
%   Simulation_results = gpensim(png, dynamic);
%   print_statespace(Simulation_results);

HH_MM_SS = sim_results.HH_MM_SS; % printing style for time 

if ~strcmp(sim_results.type, 'simulation'), 
    error('expects parameter [sim_results]');
end;

Place_Names = sim_results.Place_Names;
Transition_Names = sim_results.Transition_Names;
Ps = size(Place_Names, 1);  Ts = size(Transition_Names, 1);

place_names = [];
for i=1:Ps, place_names = [place_names, Place_Names(i, :)];  end;

RT_SIM_LOG = sim_results.State_Diagram; 
[no_of_rows, n] = size(RT_SIM_LOG); 

state = 0;
start_time = RT_SIM_LOG(1, 1);
%%%%%%%%%%%%%%%%% print initial state
initial_markings = RT_SIM_LOG(1, 3:2+Ps);
if (HH_MM_SS), 
    disp(['    Time: ', string_HH_MM_SS(start_time)]);
else disp(['    Time: ', num2str(start_time)]);
end;

disp('State:0 (Initial State)'); disp(place_names);  
print_markings(initial_markings); 

enabled_trans = RT_SIM_LOG(2, end+1-Ts:end);
print_statespace_enabled_trans(enabled_trans, start_time,...
    Transition_Names, HH_MM_SS);

firing_trans = RT_SIM_LOG(3, end+1-Ts:end);
print_statespace_firing_trans(firing_trans, start_time, ...
    Transition_Names, HH_MM_SS);

%%%%%%%%%%%%%%%%% print states
for i = 4:3:no_of_rows-2,
    % row - 1:     
    finishing_time = RT_SIM_LOG(i, 1); 
    fired_event = RT_SIM_LOG(i, 2);
    current_markings = RT_SIM_LOG(i, 3:2+Ps);
    if (fired_event),  
        fired_event_name = Transition_Names(fired_event, :);
        state = state + 1; 
        print_statespace_state(fired_event, fired_event_name, ...
            finishing_time, place_names, current_markings, state, HH_MM_SS);
    end;
    
    % row - 2: Enabled Transitions
    checking_time = RT_SIM_LOG(i+1, 1);
    enabled_trans = RT_SIM_LOG(i+1, end+1-Ts:end);
    print_statespace_enabled_trans(enabled_trans,checking_time,...
        Transition_Names, HH_MM_SS);
    
    % row - 3: Firing Transitions
    checking_time = RT_SIM_LOG(i+2, 1);
    firing_trans = RT_SIM_LOG(i+2, end+1-Ts:end);
    if any(firing_trans),
        print_statespace_firing_trans(firing_trans,checking_time,...
            Transition_Names, HH_MM_SS);
    end;
end;    


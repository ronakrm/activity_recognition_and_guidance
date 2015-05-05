function [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(sim, set_of_transitions, global_info)
% [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(sim, set_of_transitions, global_info)
%
% E.g. [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(png, sim, {'tr_1', tr_2'});
%
% Function extracts start-times and stop-times of transition firing
% 
%
% Define variables: 
% Inputs: 	PN: the Petri net structure; SIM: simulation results 
%          set_of_transitions: (string)
%
% Output:  OCCUPANCY_MATRIX: time taken by each transition 
%          DURATION_MATRIX: first column: transition_index 
%                           second column: start time
%                           third column: stop time
% Functions called : extractt

% RD 05.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts = size(sim.Transition_Names, 1);

DURATION_MATRIX = extractt(sim, set_of_transitions);
nr_rows = size(DURATION_MATRIX, 1);

[lrows, lcols] = size(sim.LOG);
complete_time = sim.LOG(lrows, lcols);
OCCUPANCY_MATRIX = zeros(2, Ts); 

for i=1:nr_rows,
    firing_event = DURATION_MATRIX(i, 1);
    OCCUPANCY_MATRIX(2, firing_event) = 1; % set flag bit 
    startTIME = DURATION_MATRIX(i, 2);
    stopTIME = DURATION_MATRIX(i, 3);
    durationTIME = stopTIME - startTIME;
    OCCUPANCY_MATRIX(1, firing_event) = ...
        OCCUPANCY_MATRIX(1, firing_event)+ durationTIME; % occupied time
end;

for i=1:Ts,
    if OCCUPANCY_MATRIX(2,i), 
        disp(['occupancy ', sim.Transition_Names(i, :), ': ']);
        total_occu_time = OCCUPANCY_MATRIX(1, i);
        percentage_time = (total_occu_time/complete_time)*100;
        disp(['  total time: ', num2str(total_occu_time)]);
        disp(['  Percentage time: ', num2str(percentage_time), '%']);
    end;
end;

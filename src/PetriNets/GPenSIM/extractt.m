function [DURATION_MATRIX] = extractt(sim, set_of_transitions)
% [DURATION_MATRIX] = extractt(sim, set_of_transitions)
% function [DURATION_MATRIX] = extractt(png, sim, ...
%         set_of_transitions)
% return a matrix with three colums: 
%     firing-transition, start-time stop-time

Ps = size(sim.Place_Names, 1);
Transition_Names = sim.Transition_Names;
Ts = size(Transition_Names, 1);

[m, n]= size(sim.LOG);
event_timing_log = sim.LOG(2:m, [Ps+1, Ps+3:n]);

[m2, n2] = size(event_timing_log);
maxtime = event_timing_log(m2, n2);
T_INDICE = [];
DURATION_MATRIX = [];

for i=1:length(set_of_transitions),
    transition_name = set_of_transitions{i};
    t_index = 0; found = 0;
    while and(~(found), lt(t_index, Ts)),        
        t_index = t_index + 1;
        found = strcmp(Transition_Names(t_index,:), ...
            good_name(transition_name));
    end;
    
    if (t_index),
        T_INDICE = [T_INDICE t_index];
    else
        error(['unrecognizeable: ', transition_name]);
    end;
end;

for i=1:length(set_of_transitions),
    t_index = T_INDICE(i);
    firing_transitions=event_timing_log(:,1)';
    index=(firing_transitions==t_index);
    submatrix = event_timing_log(index',:);
    [sm, sn]=size(submatrix);
        
    for j=1:sm,
        startT = submatrix(j,2);
        stopT = submatrix(j,3);
        DURATION_MATRIX = [DURATION_MATRIX; ...
            t_index startT stopT];
    end;
end;

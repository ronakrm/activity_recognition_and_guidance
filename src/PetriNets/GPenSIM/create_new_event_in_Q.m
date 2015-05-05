function [new_event] = create_new_event_in_Q(pn, transition1, ...
    delta_X, output_place, parent_index)
% [new_event_in_Q] = create_new_event_in_Q(pn,trans,deltaX,outputPl, ...
%                       parentIndex)
%

new_event.start_time = pn.current_time; %it can be local time

% completion time
ftime = pn.Set_of_Firing_Times(transition1);

if isnan(ftime),  % firing time is a string; e.g. 'unifrnd(10, 12)'
    trans = pn.global_transitions(transition1);
    ftime = eval(trans.firing_time);
end;
new_event.firing_time = pn.current_time + ftime; % completion time

new_event.delta_X = delta_X; %tokens to be deposited
new_event.output_place = output_place; %output places
new_event.event = transition1;
new_event.parent = parent_index;%parent transition fired before current 

function [et] = event_timing(pn, transition)
% [et] = event_timing(pn, transition)


wfqfwfwfwfwfwfwfwfwfw

ftime = pn.Set_of_Firing_Times(transition);

if isnan(ftime),  % firing time is a string; e.g. 'unifrnd(10, 12)'
    ftime = eval(pn.global_transitions(transition).firing_time);
end;

et = ftime;

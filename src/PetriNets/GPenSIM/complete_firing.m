function [pn, EIP, log_record, colormap_record, global_info] = ...
    complete_firing(pn, EIP, global_info)
% [pn, EIP, logRecord, colormapRecord, global_info] = ...
%       complete_firing(pn, EIP, global_info)

event_in_Q = EIP(1);%pop an event from queue 
t1 = event_in_Q.event; % firing transition
EIP = EIP(2:end); %transition is completing, so remove from Queue
pn.current_time = event_in_Q.firing_time; % firing completion time 
pn.Firing_Transitions(t1)=0; % trans has fired thus available

% deposit new tokens
delta_X = event_in_Q.delta_X;
pn.X    = pn.X + delta_X;
for i=1:length(delta_X),
    if delta_X(i),
        pn = deposit_token(pn,i,delta_X(i), event_in_Q.add_color);
    end;
end;      

pn.global_transitions(t1).times_fired = ...
    pn.global_transitions(t1).times_fired+1;
log_record= [pn.X, t1, event_in_Q.parent, ...
    event_in_Q.start_time, pn.current_time];

% after all the deposits, now get the colors picture in color_map 
colormap_record = get_current_colors(pn);

% finally perform, if any, post actions of the firing 
[pn, global_info] = firing_postactions(t1, pn, global_info); 

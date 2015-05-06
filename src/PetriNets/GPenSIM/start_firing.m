function [pn,EIP, global_info]= ...
    start_firing(pn,EIP,parent_index,global_info)
% [pn,EIP,global_info]=start_firing(pn,EIP,parent_index,global_info)
% First generate random event order random_events
% Then check for enabled transitions, one by one
% If any enabled, compute token removal and deposits
% Put the transition in its respective place in queue

[cols, enabledTrans] = find(pn.Enabled_Transitions > 0);

% enabled transitions to be fired PRIORITY based or RANDOMLY?
priority_exist = any(pn.priority_list);
if priority_exist,
    set_of_ordered_enabledTrans = ...
        priority_enabled_trans(pn, enabledTrans);
else
    set_of_ordered_enabledTrans = randomgen(enabledTrans);
end;


No_of_enabledTrans = length(enabledTrans);

%%% LOOP 
for i = 1:No_of_enabledTrans, %check events one by one 
    t1 = set_of_ordered_enabledTrans(i);
      
    if and(pn.Enabled_Transitions(t1),...  % enabled & not currently firing
            ~(pn.Firing_Transitions(t1))), 

        [fcs, pn, new_color, override, selected_tokens, global_info] = ...
            firing_preconditions(t1,pn,global_info); 

        if fcs, % firing conditions satisfied, let the transition fire
            pn.Firing_Transitions(t1)=1;  % 
                      
            % token removals and computing deposits                    
            [pn,delta_X,output_place,inherited_color]=...
                consume_tokens(pn,t1,selected_tokens); 
            % create new event to be put in Queue
            new_event_in_Q = create_new_event_in_Q(pn, t1, ...
                delta_X, output_place, parent_index);

            if (override), colorset = new_color; 
            else colorset = union(new_color,inherited_color);
            end;
            if ischar(colorset), colorset = {colorset}; end;
            new_event_in_Q.add_color = colorset;
            EIP = add_to_events_queue(pn, new_event_in_Q, EIP); %add event to Queue 
            
            % determine new enabled trans after token removal
            for j = 1:No_of_enabledTrans, %check events one by one 
                
                t2 = set_of_ordered_enabledTrans(j); 
                pn.Enabled_Transitions(t2) = enabled_transition(t2, pn); %check if enabled
            end;            
        end; % if fcs, 
    end; %if enabled_transition
end; %for t = 1:

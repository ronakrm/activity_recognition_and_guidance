function [] = print_statespace_state(fired_event, fired_event_name, ...
    finishing_time, place_names, current_markings, state, HH_MM_SS)
% function [] = print_statespace_state(fired_event, fired_event_name, ...
%    finishing_time, place_names, current_markings, state, HH_MM_SS)

fprintf('\n');

if (HH_MM_SS), 
    disp(['    Time: ', string_HH_MM_SS(finishing_time)]);
else
    disp(['    Time: ', num2str(finishing_time)]);
end;


if (fired_event), % this is a state transition 
    disp(['State: ', num2str(state)]);
    disp(['Fired Transition: ', fired_event_name]);
    
    disp('Current State:'); 
    disp(place_names);  
    print_markings(current_markings); 
    
else
    %%% this is an intermediate state
    disp('Intemediate State: '); 
  
    disp('Current Markings:'); 
    disp(place_names);  
    print_markings(current_markings);    
end;


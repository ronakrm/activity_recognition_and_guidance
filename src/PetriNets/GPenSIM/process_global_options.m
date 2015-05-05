function [png] = process_global_options(png, global_info)
% function [png] = process_global_options(png, global_info)
%  

Ts = png.No_of_transitions;

% process MAX_LOOP
if isfield(global_info, 'MAX_LOOP'),
    png.MAX_LOOP = global_info.MAX_LOOP;
else
    png.MAX_LOOP = 200;
end;

% process DELTA_TIME
png.delta_T = 0;
if isfield(global_info, 'DELTA_TIME'),
    png.delta_T = global_info.DELTA_TIME;
end;

% process HH_MM_SS (Hour-Min-Sec Format) & Starting Time
png.HH_MM_SS = 0; % assume initially for Hour-Min-Sec flag
if isfield(global_info, 'STARTING_AT');
    st = global_info.STARTING_AT;
    % STARTING_TIME = start_at(global_info.Start_At); 
    if ischar (st),  % starting time is a string; e.g. 'unifrdn(10, 12)'
        STARTING_TIME  = eval(st); 
    elseif eq(length(st), 3),  % starting time is vector [hh mm ss]
        png.HH_MM_SS = 1; % set Hour-Min-Sec flag
        STARTING_TIME = st(3) + (60 * st(2)) + (60 * 60 * st(1)); % convert to seconds
    else   % firing time is in seconds 
        STARTING_TIME = st;
    end;
else
    STARTING_TIME = 0;
end;
png.current_time = STARTING_TIME;

% process PRINT_LOOP
png.PRINT_LOOP_NUMBER = isfield(global_info, 'LOOP_NUMBER');

% process PRIORITY
priority_list = zeros(1, Ts);
if isfield(global_info, 'PRIORITY'),
    lenPrio = length(global_info.PRIORITY);
    for i = 1:2:(lenPrio-1),
        tname = global_info.PRIORITY{i};
        initial_priority = global_info.PRIORITY{i+1};
      
        t_index = is_trans(png, tname);
        if (t_index),
            priority_list(t_index) = initial_priority;
        else 
            warning([tname, ' wrong transition name in priority list']);
        end;
    end;
end;

png.priority_list = priority_list;


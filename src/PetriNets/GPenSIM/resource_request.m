function [acquired, PN] = resource_request(PN, trans_name, ...
                                                specific_resources)
% function [acquired, PN] = resource_request(PN, trans_name, ...
%                   specific_resources)

% check transition name
tx = is_trans(PN, trans_name);
if ~(tx), 
    error([trans_name, ' : wrong transition name']);
end;

occupied_resources = PN.resources.reserved;
acquired = 1;  % successful, to start with

if eq(nargin, 2),  % acquire_resource(PN, trans_name)
    avilable_resources = ~occupied_resources;
    
    % find any available res (value ~= 0)
    [row, cols] = find(avilable_resources);  
    if ~isempty(cols),
        resource1 = cols(1); % which is the first avialble semafor
        PN.resources.reserved(resource1) = tx;  % then reserve it
        % register reservation time
        PN.resources.reservation_time(resource1)= PN.current_time; % reservation time
    else
        acquired = 0;  % unsuccessful
    end;
end;

if eq(nargin, 3),
    lenSR = length(specific_resources);
    ri_set = [];
    
    for i=1:lenSR,
        [TF, r_index]=ismember(specific_resources{i}, PN.resources.names);
        if ~TF, 
            error([specific_resources{i}, ' : unknown resource name']);
        end;

        if ~occupied_resources(r_index), % resource empty
            ri_set = [ri_set r_index];
        else
            acquired = 0;  % unsuccessful
            return;
        end;
    end;
    
    PN.resources.reserved(ri_set) = tx;  % then reserve it
    % register reservation time        
    PN.resources.reservation_time(ri_set)= PN.current_time; % reservation time
 %   disp([PN.resources.reserved]);
end;

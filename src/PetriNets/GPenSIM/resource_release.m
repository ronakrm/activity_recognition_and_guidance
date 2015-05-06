function [released, PN] = resource_release(PN, trans_name)
% function [released, PN] = resource_release(PN, trans_name)
% this function releases all the resources the specified transition
% is holding.
%
% Usage:
%   Inputs:
%       PN: Petri net runtime sturcture
%       trans_name: name of the specified transition
%
%   Outputs:
%       PN: Petri net runtime sturcture
%       released: name of the specified transition

tx = is_trans(PN, trans_name); % get the transition ID
if ~(tx), % if not a valid transition 
    error([trans_name, ' : wrong transition name']);
end;

% disp(['before releasing ...', trans_name, '  ', num2str(tx)]);
% disp([PN.resources.reserved]);

resources = find(PN.resources.reserved==tx); % resources held by the trans
if isempty(resources),
    released = 0;
else
    PN.resources.reserved(resources) = 0; % release the resources

    % log usage
    res_released_time = PN.current_time; % resource released time
    for i=1:length(resources),
        res_reservation_time = PN.resources.reservation_time(resources(i)); 
        use_log = [resources(i) tx  ...
            res_reservation_time res_released_time];
        PN.resources.usage_LOG = [PN.resources.usage_LOG; use_log];
    end;
    released = 1;
end;

% disp(['after releasing ...',num2str(tx)]);disp([PN.resources.reserved]);
% disp(' ');

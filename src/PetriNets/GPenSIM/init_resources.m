function [png] = init_resources(png, resources)
% function [png] = init_resources(png, resources)


Rs = length(resources);  % number of resources

res.names = resources;
res.reserved = zeros(1, Rs);    % initially no resource are reserved
res.reservation_time = zeros(1, Rs);    %initially none are reserved
res.usage_LOG = [];

png.resources = res;






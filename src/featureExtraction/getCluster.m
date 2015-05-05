function [symbol] = getCluster(clusters, observation)
%   Returns the index of the closest cluster center candidate given an
%   input HOOF observation. This will serve as the observation symbol
%
%   Inputs:
%       clusters - the cluster centers
%       observation - the HOOF feature needing a sequence
%   Outputs:
%       symbol - the index of the nearest cluster center

    % get distance from HOOF feature to each cluster
    distance = pdist2(observation, clusters);
    
    % find index of the nearest cluster to the HOOF feature
    % this is the observed symbol
    [minimum, symbol] = min(distance);
    
end


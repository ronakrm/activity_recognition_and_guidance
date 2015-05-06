function [codebook] = doClusteringExcludingI(i, numVideos, numActions, numBins, numClusters)
%   Cluster videos using numClusters clusters but not use video i
%
%   Inputs:
%       i - the video index to exclude
%       numVideos - the total number of videos
%       numClusters - the number of clusters

% initialize parameters
pathToData = '../../data/';

superHoof = zeros(1,numBins);

% get all observable symbol sequences of all actions
for actIndex = 1 : numActions
    
    % iterate through all videos to get observable sequences from
    % actions
    for folderIndex = 1 : numVideos
        %exclude i
        if folderIndex == i
            continue
        end
        
        % import sequences
        videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
        currentFile = strcat(videoDir, 'a', num2str(actIndex), ...
            '_hoof.csv');
        
        % add sequence to all sequences
        thisActionHoofs = csvread(currentFile);
        
        superHoof = [superHoof; thisActionHoofs];        
    end
    
end
% this removes the initialization line
superHoof(1,:) = [];

[~, clusterCenters] = kmeans(superHoof, numClusters, 'MaxIter', 500);
csvwrite(strcat(pathToData, 'codebook.csv'), clusterCenters);
codebook = clusterCenters;

end


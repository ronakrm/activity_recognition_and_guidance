function generateSequences(numVideos, numActions)
% call this before getSequences and after doClusteringExcludingI

pathToData = '../../data/';

codebook = csvread(strcat(pathToData, 'codebook.csv'));

for folderIndex = 1:numVideos
    % go to the video's directory - data/v1/
    videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
    
    % generate state sequences for each action
    for actIndex = 1:numActions
        currentFile = strcat(videoDir, 'a', num2str(actIndex), '_hoof.csv');
        
        % read in the file
        hoofs = csvread(currentFile);
        
        outputMat = zeros(size(hoofs,1),1);
        
        % for each frame, find the closest cluster in clusterCenters and
        % write the index to the output
        for frame = 1: size(hoofs,1)
            closest = getCluster(codebook, hoofs(frame,:));
            outputMat(frame) = closest;
        end
        
        % save output matrix as a3_sequence.csv
        outFileName = strcat('a', num2str(actIndex), '_sequence.csv');
        csvwrite(strcat(videoDir, outFileName), outputMat);
    end
end


end
% this sits outside the data directory
% optical flow files are in data/v1/f1/f123.txt, for example

% create HOOF features for videos videoStartNum through videoEndNum,
% inclusive. assumes that optical flow follow the structure above and are
% already created. also clusters them according to the input number of
% clusters using k-means to generate the symbols for the HMM.
function hoofgen(videoStartNum, videoEndNum)

numClusters = 80;
numBins = 30;
numActions = 8;

superHoof = cell(1,numBins);
superIndex = 1;

pathToData = '../../data/';

for folderIndex = videoStartNum:videoEndNum
    % go to the video's directory
    videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
    
    % generate hoof features for each action
    for actIndex = 1:numActions
        currentDir = strcat(videoDir, 'f', num2str(actIndex), '/');
        
        % get number of flow files in directory
        flows = dir(fullfile(currentDir));
        flows(1)=[];flows(1)=[];
        num_flows = size(flows,1);
        
        outputMat = zeros(num_flows, 30);
        
        % files are named 1...num_files.txt, so iterate
        for flow = 1:num_flows
            thisFile = strcat(currentDir, 'f', num2str(flow), '.csv');
            
            flowData = csvread(thisFile);
            % n x 2 matrix, with column 1 the x's and column 2 the y's
            
            hoof = gradientHistogram(flowData(:,1), flowData(:,2), numBins);
            
            % save these hoof features to the output matrix
            outputMat(flow, :) = hoof';
            superHoof(superIndex,:) = num2cell(hoof');
            superIndex = superIndex + 1;
        end
        
        % save output matrix as a3_hoof.csv
        outFileName = strcat('a', num2str(actIndex), '_hoof.csv');
        csvwrite(strcat(videoDir, outFileName), outputMat);
    end
end

%%
% now that we've generated everything, cluster them
disp('starting clustering. this may take a while');

[~, clusterCenters] = kmeans(cell2mat(superHoof), numClusters);
csvwrite(strcat(pathToData, 'codebook.csv'), clusterCenters);

disp('clustering done. codebook file written!');
%%

% now go over the generated a1_hoof.csv files and make new files containing
% the symbol sequences by comparing each hoof to the clusters

disp('generating sequences for each action');

for folderIndex = videoStartNum:videoEndNum
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
            closest = getCluster(clusterCenters, hoofs(frame,:));
            outputMat(frame) = closest;
        end
        
        % save output matrix as a3_sequence.csv
        outFileName = strcat('a', num2str(actIndex), '_sequence.csv');
        csvwrite(strcat(videoDir, outFileName), outputMat);
    end
end






end
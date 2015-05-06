% this sits outside the data directory
% optical flow files are in data/v1/f1/f123.txt, for example

% create HOOF features for videos videoStartNum through videoEndNum,
% inclusive. assumes that optical flow follow the structure above and are
% already created. also clusters them according to the input number of
% clusters using k-means to generate the symbols for the HMM.
function hoofgen(numVideos, numActions, numBins)

pathToData = '../../data/';

for folderIndex = 1:numVideos
    % go to the video's directory
    videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
    
    % generate hoof features for each action
    for actIndex = 1:numActions
        currentDir = strcat(videoDir, 'f', num2str(actIndex), '/');
        
        % get number of flow files in directory
        flows = dir(fullfile(currentDir));
        flows(1)=[];flows(1)=[];
        num_flows = size(flows,1);
        
        outputMat = zeros(num_flows, numBins);
        
        % files are named 1...num_files.txt, so iterate
        for flow = 1:num_flows
            thisFile = strcat(currentDir, 'f', num2str(flow), '.csv');
            
            flowData = csvread(thisFile);
            % n x 2 matrix, with column 1 the x's and column 2 the y's
            
            hoof = gradientHistogram(flowData(:,1), flowData(:,2), numBins);
            
            % save these hoof features to the output matrix
            outputMat(flow, :) = hoof';
        end
        
        % save output matrix as a3_hoof.csv
        outFileName = strcat('a', num2str(actIndex), '_hoof.csv');
        csvwrite(strcat(videoDir, outFileName), outputMat);
    end
end

end
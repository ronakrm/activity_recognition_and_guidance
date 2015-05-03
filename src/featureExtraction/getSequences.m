function [sequences] = getSequences(videoStartNum, videoEndNum)
%   Get the observed sequences for each action and creates a cell array of
%   all observed sequences
% 
%   Inputs:
%       videoStartNum - the index of the first video
%       videoEndNum - the index of the second video

    
    numActions = 8;
    pathToData = '../../data/';
    
    % initialize cell array
    sequences = cell(8,5);
    
    % get all observable symbol sequences of all actions
    for actIndex = 1 : numActions
        
        % iterate through all videos to get observable sequences from
        % actions
        for folderIndex = videoStartNum : videoEndNum
            % import sequences
            videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
            currentFile = strcat(videoDir, 'a', num2str(actIndex), ...
                '_sequence.csv');
            
            % add sequence to all sequences
            sequences{actIndex,folderIndex} = csvread(currentFile)';
        end
        
    end

end


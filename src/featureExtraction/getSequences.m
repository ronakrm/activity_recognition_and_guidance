function [sequences] = getSequences(numVideos, numActions)
%   Get the observed sequences for each action and creates a cell array of
%   all observed sequences
% 
%   Inputs:
%       numVideos - the total number of videos
%       numActions - the total number of actions
%   Outputs:
%       sequences - all observed sequences

    % initialize parameters
    pathToData = '../../data/';
    
    % initialize cell array
    sequences = cell(8,5);
    
    % get all observable symbol sequences of all actions
    for actIndex = 1 : numActions
        
        % iterate through all videos to get observable sequences from
        % actions
        for folderIndex = 1 : numVideos
            % import sequences
            videoDir = strcat(pathToData,'v', num2str(folderIndex), '/');
            currentFile = strcat(videoDir, 'a', num2str(actIndex), ...
                '_sequence.csv');
            
            % add sequence to all sequences
            sequences{actIndex,folderIndex} = csvread(currentFile)';
        end
        
    end

end


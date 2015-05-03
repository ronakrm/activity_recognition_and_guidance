function [accuracy] = crossValidation(sequences)
%   Performs cross-validation testing to determine accuracy for action
%   recognition
% 
%   Inputs:
%       sequences - the observed sequences of all actions in all videos
    
    % initialize parameters
    numStates = 8;
    numSymbols = 80;
    numVideos = size(sequences,2);
    numActions = size(sequences,1);
    test_count = 0;
    incorrect = 0;
    
    % perform leave-one-out cross-validation on all videos
    for i = 1 : numVideos
        
        % create training and test set
        trainSet = sequences;
        trainSet(:,i) = [];
        testSet = sequences(:,i);
        
        % train the HMM models on the training set
        models = generateHMMs(numActions, numSymbols, numStates, ...
            trainSet); 
        
        % test each action of the testing set video on the HMM models
        for j = 1 : numActions
            
            % find which action was recognized
            [max_likelihood, max_index] = testLikelihood(models, testSet(j));
            
            % if the correct action was recognized
            if(max_index ~= j)
               incorrect = incorrect + 1; 
            end
            
            test_count = test_count + 1;
        end
    end

    % return the overall accuracy
    accuracy = (test_count - incorrect) / test_count;
    
end


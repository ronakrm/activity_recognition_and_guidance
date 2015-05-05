function [accuracy, actionAccuracies] = crossValidation(numHoofBins, numStates, numSymbols, numHMMIters)
%   Performs cross-validation testing to determine accuracy for action
%   recognition
%
%   Inputs:
%       sequences - the observed sequences of all actions in all videos
%   Outputs:
%       accuracy - the overall accuracy of the action recognition
%       actionAccuracies - the accuracy of each action classification

% initialize constraints
numVideos = 30;
numActions = 8;

% initialize hoof parameters
% numHoofBins = 10;
% 
% % initialize hmm parameters
% numStates = 3;
% numSymbols = 50;
% numHMMIters = 5;

% generate your hoofs
disp('generating hoof features.');
hoofgen(numVideos, numActions, numHoofBins);
fprintf('hoof features generated.\n');

actionAccuracies = zeros(numActions,1);

% perform leave-one-out cross-validation on all videos
for i = 1 : numVideos
    fprintf('starting validation without video %d\n', i);
    % cluster without the guy
    doClusteringExcludingI(i, numVideos, numHoofBins, numSymbols);
    
    % generate sequences using the codebook made above
    generateSequences(numVideos, numActions);
    
    % get our test/train sequence
    sequences = getSequences(numVideos, numActions);
    
    % create training and test set
    trainSet = sequences;
    trainSet(:,i) = [];
    testSet = sequences(:,i);
    
    % train the HMM models on the training set
    models = generateHMMs(numActions, numSymbols, numStates, ...
        trainSet, numHMMIters);
    
    % test each action of the testing set video on the HMM models
    for j = 1 : numActions
        
        % find which action was recognized
        [max_likelihood, max_index, likelihoods] = testLikelihood(models, testSet(j));
        
        % if the correct action was recognized
        if(max_index == j)
            actionAccuracies(j) = actionAccuracies(j) + 1;
        end
    end
end

% return the overall accuracy
actionAccuracies = actionAccuracies / numVideos;
accuracy = mean(actionAccuracies);
end


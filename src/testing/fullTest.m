function [accuracy, actionAccuracies] = fullTest(numHoofBins, numStates, numSymbols, numHMMIters)
%   Performs cross-validation testing to determine accuracy for action
%   recognition
%
%   Inputs:
%       sequences - the observed sequences of all actions in all videos
%   Outputs:
%       accuracy - the overall accuracy of the action recognition
%       actionAccuracies - the accuracy of each action classification


% THESE ARE ALSO CODED INTO gridSearcher!! Make sure to change there
% also!
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

rng(1337);

%hoof generation moved to gridSearcher, left commented here for individual
%testing needs
% generate your hoofs
%disp('generating hoof features.');
hoofgen(numVideos, numActions, numHoofBins);
%fprintf('hoof features generated.\n');

actionAccuracies = zeros(numActions,1);


global likelihoods;
% action = struct('removeElecronicDisplay',zeros(1),...
%                 'unscrewFirstHandGrip',zeros(1),...
%                 'unscrewSecondHandGrip',zeros(1),...
%                 'attachDrillHead',zeros(1),...
%                 'removeFirstStep',zeros(1),...
%                 'removeSecondStep',zeros(1),...
%                 'removeKnob',zeros(1),...
%                 'removeWheel',zeros(1));     

% perform leave-one-out cross-validation on all videos
for i = 1 : numVideos
    fprintf('starting validation without video %d\n', i);
    % cluster without the guy
    doClusteringExcludingI(i, numVideos, numActions, numHoofBins, numSymbols);
    
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
    
    png = petrinetgraph('definePetriNet');
    dyn.initial_markings = {'RED', 2}; % tokens initially    
    
    % test each action of the testing set video on the HMM models
    for j = 1 : numActions
        
%         action.removeElectronicDisplay = 0;
%         action.unscrewFirstHandGrip = 0;
%         action.unscrewSecondHandGrip = 0;
%         action.attachDrillHead = 0;
%         action.removeFirstStep = 0;
%         action.removeSecondStep = 0;
%         action.removeKnob = 0;
%         action.removeWheel = 0;
        
        % find which action was recognized
        [max_likelihood, max_index, likelihoods] = testLikelihood(models, testSet(j));
        
%         switch max_index
%             case 1
%                 action.removeElectronicDisplay = 1;
%             case 2
%                 action.unscrewFirstHandGrip = 1;
%             case 3
%                 action.unscrewSecondHandGrip = 1;
%             case 4
%                 action.attachDrillHead = 1;
%             case 5
%                 action.removeFirstStep = 1;
%             case 6
%                 action.removeSecondStep = 1;
%             case 7
%                 action.removeKnob = 1;
%             case 8
%                 action.removeWheel = 1;
%             otherwise
%         end
        
        sim = gpensim(png, dyn);
        print_statespace(sim);
    end
end

% return the overall accuracy
actionAccuracies = actionAccuracies / numVideos;
accuracy = mean(actionAccuracies);
end


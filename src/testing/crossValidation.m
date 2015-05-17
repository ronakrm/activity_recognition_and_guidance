function [accuracy, actionAccuracies] = crossValidation(numHoofBins, numStates, numSymbols, numHMMIters)
%   Performs cross-validation testing to determine accuracy for action
%   recognition
%
%   Inputs:
%       sequences - the observed sequences of all actions in all videos
%   Outputs:
%       accuracy - the overall accuracy of the action recognition
%       actionAccuracies - the accuracy of each action classification

% initialize the action recognitions
global actions;
actions = struct('removeElectronicDisplay',zeros(1), ...
                 'unscrewFirstHandGrip',zeros(1), ...
                 'unscrewSecondHandGrip',zeros(1), ...
                 'attachDrillHead', zeros(1), ...
                 'removeFirstStep', zeros(1), ...
                 'removeSecondStep', zeros(1), ...
                 'removeKnob', zeros(1), ...
                 'removeWheel', zeros(1));
             
%histories for transition firing on multiple conditions      
global unscrewFirstHandGrip;
global unscrewSecondHandGrip;
global removeFirstStep;
global removeSecondStep;
   
% initialize petri net
global_info.MAX_LOOP = 40;
global_info.STARTING_AT = [1 0 0];
global_info.LOOP_NUMBER = 1;

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
%hoofgen(numVideos, numActions, numHoofBins);
%fprintf('hoof features generated.\n');

actionAccuracies = zeros(numActions,1);

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
    
    % create a new petri net
    png = petrinetgraph('definePetriNet');
    dyn.initial_markings = {'RED', 2}; % tokens initially
    
    unscrewFirstHandGrip = 0;
    unscrewSecondHandGrip = 0;
    removeFirstStep = 0;
    removeSecondStep = 0;
    
    % test each action of the testing set video on the HMM models
    for j = 1 : numActions
        poss_actions = simPetri(j);
        weights = ones(numActions,1);
        weights(poss_actions) = 0.98;
        % find which action was recognized
        [max_likelihood, max_index, likelihoods] = testLikelihood(models, testSet(j), weights);

        % update the global action recognition likelihoods
        actions.removeElectronicDisplay = likelihoods(1);
        actions.unscrewFirstHandGrip = likelihoods(2);
        actions.unscrewSecondHandGrip = likelihoods(3);
        actions.attachDrillHead = likelihoods(4);
        actions.removeFirstStep = likelihoods(5);
        actions.removeSecondStep = likelihoods(6);
        actions.removeKnob = likelihoods(7);
        actions.removeWheel = likelihoods(8);
        
        % update the petri net
        %sim = gpensim(png, dyn, global_info);
        
        % if the correct action was recognized
        if(max_index == j)
            actionAccuracies(j) = actionAccuracies(j) + 1;
        end
    end
    
    %print the petri net statespace
    %print_statespace(sim);
end

% return the overall accuracy
actionAccuracies = actionAccuracies / numVideos;
accuracy = mean(actionAccuracies);
end


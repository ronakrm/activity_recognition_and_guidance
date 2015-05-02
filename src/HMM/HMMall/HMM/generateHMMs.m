function [models] = generateHMMs(numActions, numSymbols, states, sequences)
%GENERATEHMMS Summary of this function goes here
%   Generates the HMM models based on the number of actions to classify
%   
%   Input parameters are:
%       numActions - the total number of actions to clasisfy
%       numSymbols - the number of observable symbols
%       states - the number of states in the HMMs
%       sequences - the training sequences to generate HMM models

    % generate an HMM for every action
    for i = 1 : numActions
        % save number of states and symbols to model
        models(i).states = states;
        models(i).symbols = numSymbols;
       
        % initial guess of parameters
        models(i).prior = normalise(rand(models(i).states,1));
        models(i).transmat = mk_stochastic(rand(models(i).states,models(i).states));
        models(i).obsmat = mk_stochastic(rand(models(i).states,models(i).symbols));
        
        % improve guess of parameters using EM
        [LL, bestPrior, bestTransmat, bestObsmat] = dhmm_em(sequences, ...
                models(i).prior, models(i).transmat, models(i).obsmat, ...
                    'max_iter', 5);
        
        % save model parameters to model
        models(i).prior = bestPrior;
        models(i).transmat = bestTransmat;
        models(i).obsmat = bestObsmat;
    end

end


function [models] = generateHMMs(numActions, numSymbols, states, sequences, numHMMIters)
%   Generates the HMM models based on the number of actions to classify
%   
%   Inputs:
%       numActions - the total number of actions to clasisfy
%       numSymbol - the total number of observable symbols
%       states - the number of states in the HMMs
%       sequences - the training sequences to generate HMM model
    
    % initialize the models
    models(1:8) = struct('states',zeros(1),'symbols',zeros(1),...
        'prior',rand(states,1),'transmat',rand(states,states),'obsmat',...
            rand(states,numSymbols));

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
        [LL, bestPrior, bestTransmat, bestObsmat] = dhmm_em(sequences(i,:), ...
                models(i).prior, models(i).transmat, models(i).obsmat, ...
                    'max_iter', numHMMIters);
        
        % save model parameters to model
        models(i).LL = LL;
        models(i).prior = bestPrior;
        models(i).transmat = bestTransmat;
        models(i).obsmat = bestObsmat;
    end
end


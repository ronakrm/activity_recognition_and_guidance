function [max_likelihood, max_index, likelihoods] = testLikelihood(models, sequence, weights)
%   Obtains the log liklihood of a model fitting a set of observation
%   symbols

%   Inputs:
%       models - the HMM models being tested
%       sequence - the sequence to be tested with a model

    % initialize parameters
    numActions = size(models,2);
    likelihoods = zeros(numActions,1);
    
    % find likelihood of sequence based on all actions
    for i = 1 : numActions
        % use model to compute log likelihood
        likelihoods(i) = dhmm_logprob(sequence, models(i).prior, ...
            models(i).transmat, models(i).obsmat);
    
    end
    
%     %weight actions based on weights by petri net
%     likelihoods = likelihoods.*weights;
    
    % return the maximum likelihood and the action that yielded it
    [max_likelihood, max_index] = max(likelihoods);
    
    % if all likelihoods were -inf, don't return an action
    if(isinf(max_likelihood))
        max_index = 0;
    end
end


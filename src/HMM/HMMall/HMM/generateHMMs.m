function [models] = generateHMMs(numActions, numSymbols, sequences)
%GENERATEHMMS Summary of this function goes here
%   Generates the HMM models based on the number of actions to classify
%   
%   Input parameters are:
%       numActions - the total number of actions to clasisfy
%       numSymbols - the number of observable symbols
%       sequences - the training sequences to generate HMM models
    
    models = zeros(numActions);
    
    for i = 1 : numActions
       models(i).a = 1; 
    end
    O = 3;
Q = 2;

% "true" parameters
prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));
obsmat0 = mk_stochastic(rand(Q,O));

% training data
T = 5;
nex = 10;
data = dhmm_sample(prior0, transmat0, obsmat0, T, nex);

% initial guess of parameters
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));

% improve guess of parameters using EM
[LL, prior2, transmat2, obsmat2] = dhmm_em(data, prior1, transmat1, obsmat1, 'max_iter', 5);
LL

% use model to compute log likelihood
loglik = dhmm_logprob(data, prior2, transmat2, obsmat2)
% log lik is slightly different than LL(end), since it is computed after the final M step


end


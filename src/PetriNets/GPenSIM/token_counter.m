function [TOKEN_SUMMARY] = token_counter(pn, sim_results, ...
                                set_of_places, global_info)
%% [TOKEN_SUMMARY] = token_counter(pn, sim_results, ...
%%                                set_of_places, global_info)
%%
%% E.g.  = plotp(PN, sim_res, {'buf_1', 'buff_2'});
%% This function plots variation of tokens with time.
%% Define variables: 
%% Inputs: 	PN: the Petri net structure; SIM_RES: simulation results 
%%          set_of_places: (string) 
%% Output:  TOKEN_MATRIX 
%% Functions called : extractp

%% RD 05.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TOKEN_MATRIX = extractp(pn, sim_results, set_of_places);
[m, n] = size(TOKEN_MATRIX);
time_series = TOKEN_MATRIX(2:m,1); %skip place indice
TOKENS = TOKEN_MATRIX(2:m,2:n); %ONLY TOKENS

max_tokens = TOKENS(1, :);
max_tokens_time = zeros(1, n-1);
min_tokens = TOKENS(1, :);
min_tokens_time = zeros(1, n-1);
average_tokens_ctr = zeros(1, n-1);

for pi=1:n-1,
    summ_time = 0; sum_tok= 0;  
    for t = 2: m-1,
        delta_time = time_series(t) - time_series(t-1);
        summ_time = summ_time + delta_time;
        average_tok = (TOKENS(t,pi) + TOKENS(t-1, pi) )/2;
        sum_tok = sum_tok + (average_tok * delta_time);
        
        if (TOKENS(t,pi) > max_tokens(pi)),
            max_tokens(pi) = TOKENS(t,pi);
            max_tokens_time(pi) = time_series(t);
        end;
        
        if (TOKENS(t,pi) < min_tokens(pi)),
            min_tokens(pi) = TOKENS(t,pi);
            min_tokens_time(pi) = time_series(t);
        end;
    end;
    average_tokens_ctr(pi) = sum_tok / summ_time;
end;

for pi = 1:length(set_of_places),
    disp(' '); 
    disp(['Summary for tokens in place: ', set_of_places{pi}]);
    disp(['Averge tokens:      ', num2str(average_tokens_ctr(pi))]);
    disp(['Max tokens:         ', num2str(max_tokens(pi))]);
    disp(['Max tokens at time: ', num2str(max_tokens_time(pi))]);
    disp(['Min tokens:         ', num2str(min_tokens(pi))]);
    disp(['Min tokens at time: ', num2str(min_tokens_time(pi))]);
end;

TOKEN_SUMMARY = [TOKEN_MATRIX(1,2:n);   % first row is place indice
    average_tokens_ctr; ...             % second row is average tokens 
    max_tokens; max_tokens_time; ...    % third row is maximum
    min_tokens; min_tokens_time];       % fourth row is minimum 



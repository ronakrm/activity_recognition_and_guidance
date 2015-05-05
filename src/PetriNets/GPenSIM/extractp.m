function [TOKEN_MATRIX] = extractp(sim_results, set_of_places)
% [TOKEN_MATRIX] = extractp(sim_results, set_of_places)
% 
% Name:	extractp
% Purpose:	To extract tokens from the Simulation results structure. 
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
%                   {set_of_place_names}
% Out parameters:	TOKEN_MATRIX 
%            First row :[0 set_of_place_indices]
%            Second & subsequent rows: 
%                [first column is time, other columns are tokens]
% Uses:	None
% Used by:	[main simulation file], 
%           plotp
% Example:	
%   % in main simulation file
%   sim = gpensim(png, dynamic);
%   plotp(sim, {'p1','p2','p3'});
%   extractp(sim, {'p1','p2','p3'}) % print the token matrix
% 

% RD 05.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOG = sim_results.LOG;
[nr_rows, nr_columns] = size(LOG);

TOKEN_MATRIX = zeros(1, nr_rows); % transpose of the final

Place_Names = sim_results.Place_Names;
Ps = size(Place_Names, 1);
P_INDICE = [0]; %start with 0 element

for i=1:length(set_of_places),
    place_name = set_of_places{i};
    
    pi = 0; found = 0;
    while and(~(found), lt(pi, Ps)),        
        pi = pi + 1;
        found = strcmp(Place_Names(pi,:), good_name(place_name));
    end;
    if ~found, error('Wrong place name'); end;
    if (pi),
        tok_mat = transpose(LOG(:, pi));
        TOKEN_MATRIX = [TOKEN_MATRIX; tok_mat]; 
        P_INDICE = [P_INDICE pi];
    else
        error(['unrecognizeable place name for place[', num2str(i), ']']);
    end;
end;

TOKEN_MATRIX = transpose(TOKEN_MATRIX);
time_series = LOG(:, nr_columns);
if any (time_series),
    TOKEN_MATRIX(:,1) = time_series;
else
    TOKEN_MATRIX(:,1) = [1:nr_rows]';
end;

TOKEN_MATRIX = [P_INDICE; TOKEN_MATRIX]; %% add place indice

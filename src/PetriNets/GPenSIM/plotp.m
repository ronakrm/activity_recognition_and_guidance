function [TOKEN_MATRIX] = plotp(sim_results, set_of_places, global_info)
% [TOKEN_MATRIX] = plotp(sim_results, set_of_places, global_info)
%
% Name:	plotp
% Purpose:	To plot simulation results;  to plot how tokens change with time 
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
%                   {set_of_place_names}
%                   global_info (optional)
% Out parameters:	TOKEN_MATRIX (contains tokens of places with time)
% Uses:	extractp  (extracts tokens from the SIM results structure)
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   sim = gpensim(png, dynamic);
%   plotp(sim, {'p1','p2','p3'});
% 

% RD 05.may.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TOKEN_MATRIX = extractp(sim_results, set_of_places);
[nr_rows, nr_columns] = size(TOKEN_MATRIX);

time_series = TOKEN_MATRIX(2:nr_rows,1); %skip place indice
TOKENS = TOKEN_MATRIX(2:nr_rows,2:nr_columns); %ONLY TOKENS

xunits = ''; % initially
if isfield(sim_results, 'HH_MM_SS'),
    if (sim_results.HH_MM_SS),
        if gt(sim_results.completion_time, 60*60),
            xunits = 'HOURS'; 
            time_series = time_series/(60*60);
        elseif gt(sim_results.completion_time, 60),
            xunits = 'MINUTES'; 
            time_series = time_series/60;
        else
            xunits = 'SECS';
        end; % if gt(sim_results.completion_time
    end; % (sim_results.HH_MM_SS),
end; % isfield(sim_results,HH_MM_SS)

if (nargin==3), %global_info presents drawing properties
    plot(time_series, TOKENS, global_info.line_spec);
else
    plot(time_series, TOKENS, '-h', ...
    'linewidth', 0.5, 'MarkerSize',2);
end;

legend(set_of_places);
xlabel(xunits);

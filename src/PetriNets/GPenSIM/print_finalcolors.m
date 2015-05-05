function [] = print_finalcolors(Sim_Results)
% [] = print_finalcolors (Sim_Results)
% 
% Name:	print_finalcolors
% Purpose:	To print colors of the final state 
%           (colors of the tokens that are left in the system 
%           when the simulations are complete)
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
% Out parameters:	None
% Uses:	None
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   results = gpensim(pn, dynamicpart);
%   print_finalcolors(results); 

disp(' '); disp(' ');
disp('Colors of final Tokens:'); 
disp(' '); disp(' ');

final_tokens = Sim_Results.final_tokens;
length_of_tokens = length(final_tokens);
disp(['No. of final tokens: ',num2str(length_of_tokens)]);
disp(' '); 

% print colors of the final tokens
for i=1:length_of_tokens,
    token = final_tokens(i);
    ctime = token.creation_time;
    pi = token.place;
    place_name = Sim_Results.Place_Names(pi, :);
    colors = token.color; 
    if isempty(colors),
        disp(['Time:',num2str(ctime),' Place:', place_name,...
        {' *** NO COLOR ***'}]);
    else
        disp(['Time:',num2str(ctime),' Place:', place_name,...
            ' Colors:', colors]);
    end;
end;    

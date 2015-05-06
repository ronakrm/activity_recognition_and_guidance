function [] = print_cotree(Simulation_Results)
% [] = print_cotree(Simulation_Results)
%
% Name:	print_cotree
% Purpose:	To print cotree structure 
% Input parameters:	Cotree structure (the structure output by ‘cotree’)
% Out parameters:	None
% Uses:	print_markings 
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   cotree_structure = cotree(png, dyn.initial_markings);
%   print_cotree(cotree_ structure);
 
%  RD 10. February 2006 ()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOG = Simulation_Results.LOG;
[no_of_rows, no_of_cols] = size(LOG);
Place_Names = Simulation_Results.Place_Names;
Ps = size(Place_Names, 1); % nr. of places

disp(''); disp('');
place_names = [];
for i=1:Ps, 
    place_names = [place_names Place_Names(i, :)];
end;
fprintf('\n');

%%%%% ROOT node
Current_row = LOG(1,:);   
X = Current_row(:, 1:Ps);   
Type = Current_row(:, Ps+3); %double('R')
disp('state:1  ROOT node');
disp(place_names);
print_markings(X);
fprintf('\n');

%%%%% for other nodes
for i = 2:no_of_rows, 
   Current_row = LOG(i,:);
   X = Current_row(:, 1:Ps);
   firing_event = Current_row(:, Ps+1);
   firing_event_name = Simulation_Results.Transition_Names(firing_event,:);
   Parent_row = Current_row(:, Ps+2);
   Type = Current_row(:, Ps+3); 
   
   if (~Type), Type=double(' '); end;
   disp(['state:' num2str(i), '    ',...
        'Firing event: ' firing_event_name, '     ']); 
   
   disp(place_names);
   print_markings(X);
   fprintf('Node type: ''%c''   Parent state: %d\n\n',...
       char(Type), Parent_row);
end;

disp(' '); 
disp('Boundedness:');
for i=1:Ps, 
    markings = LOG(:,i); 
    upper_bound = max(markings);
    disp([Place_Names(i,:), ' : ', num2str(upper_bound)]);
end;

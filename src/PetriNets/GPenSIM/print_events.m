function []= print_sim(pn, Simulation_Results)
%% [] = print_sim(pn, Simulation_Results)
%%
%% E.g.: print_sim(PN, Simultaion_results);
%%
%% This function prints the simulation results in an 
%% intelligible manner. The simulation results must be 
%% the output of the function 'gpensim'. 
%%
%% Define variables: 
%% Inputs:  PN (Petri net structure)
%%          Simulation_results (output of 'gpensim')
%%
%% Output: [] (null)
%%
%% Functions called : good_name, print_markings

%%  RD 10. February 2006 ()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n');
disp(pn.name); disp('');

no_places = length(pn.global_places);
disp(['Number of places: ', num2str(no_places)]);
place_names = [];
for i=1:no_places, 
    place_names= [place_names...
        good_name(pn.global_places(i).name)];
end;

disp('Initial Markings:');
disp(place_names);

LOG = Simulation_Results.LOG;
markings = LOG(1, 1:no_places);
print_markings(markings);

[no_of_rows, no_of_cols] = size(LOG);

for i = 2:no_of_rows,
    firing_event = LOG(i, no_of_cols - 3);
    firing_event_name = pn.global_transitions(firing_event).name;
    firing_time = LOG(i, no_of_cols);  % firing completion (stop) time
    starting_time = LOG(i, no_of_cols - 1);
    
    disp(' ');
    format bank, disp(['step:' num2str(i-1), '    ',...
        'Firing event: ' firing_event_name, '     ', ...
        '(Starting time: ', num2str(starting_time), ')  '...
        'Finishing Time: ' num2str(firing_time)]); 

    disp('Current markings:');    
    disp(place_names);
    markings = LOG(i, 1:no_places);
    print_markings(markings); 
    disp('');
end;

disp(['Completion time: ', num2str(LOG(no_of_rows, no_of_cols))]);
disp('');

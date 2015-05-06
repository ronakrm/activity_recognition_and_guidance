% Example-02: TDF example
% the main file to run simulation for the system given in figure-5 
clear, clc;

global_info.MAX_LOOP = 40;
global_info.STARTING_AT = [1 0 0];
global_info.LOOP_NUMBER = 1;

png = petrinetgraph('definePetriNet');
dyn.initial_markings = {'RED', 2}; % tokens initially

sim = gpensim(png, dyn, global_info);

print_statespace(sim);

% plotp(sim, {'pFrom_CNC', 'pBuffer_1', 'pBuffer_2', 'pBuffer_3'});


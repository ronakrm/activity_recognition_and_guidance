function [sim_results] = pack_sim_results(pn, ...
    Enabled_Trans_SET, Firing_Trans_SET, LOG, colormap)
% function [sim_results] = pack_sim_results(pn,...
%   Enabled_Trans_SET, Firing_Trans_SET, LOG, colormap)

Ps = pn.No_of_places;      % number of places
Ts = pn.No_of_transitions; % number of tansitions

% final enabled trans
for i = 1:Ts, pn.Enabled_Transitions(i)=enabled_transition(i,pn); end;

Enabled_Trans_SET = [Enabled_Trans_SET;       % *** NOTE: APOSTERORI ***
    pn.current_time, pn.Enabled_Transitions]; % LOG global set of enabled 
Firing_Trans_SET = [Firing_Trans_SET;
    pn.current_time, pn.Firing_Transitions]; % global set of enabled     

% pack the results
sim_results.type = 'simulation';  
sim_results.LOG = LOG;
sim_results.Firing_Transitions  = Firing_Trans_SET;
sim_results.Enabled_Transitions = Enabled_Trans_SET;
sim_results.color_map = colormap;
sim_results.completion_time = pn.current_time;
sim_results.overall_no_of_tokens_used = pn.token_serial_numer;
sim_results.HH_MM_SS = pn.HH_MM_SS; % Hour-Min-Sec flag

PNames = []; 
for i=1:Ps, PNames=[PNames; good_name(pn.global_places(i).name)];end;

TNames = [];
for i=1:Ts, TNames=[TNames; good_name(pn.global_transitions(i).name)]; end;

sim_results.Place_Names = PNames; 
sim_results.Transition_Names = TNames; 
sim_results.final_tokens = get_final_tokens(pn);
sim_results.No_of_places = Ps;
sim_results.No_of_transitions = Ts;
sim_results.resources = pn.resources;
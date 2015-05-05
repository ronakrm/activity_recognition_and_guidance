function [sim_results, global_info, pn] = timed_pensim(pn,global_info)
% [sim_results,global_info, pn]=timed_pensim(png,global_info)
% Name:	timed_pensim
% Purpose:	This is the main M-function for Petri net simulation. 
%           Inside the main loop, transitions are randomly chosen and  
%           checked whether they are enabled or not. 
%           If they are enabled, the token removal and deposition happens
%           in respective places. Then the happenings are recorded 
%           in the simulation results LOG.
% 
% Input parameters:	Static Petri net structure (output from ‘petrinetgraph’)
%                   global_info
% Out parameters:	Simulation results
%                   global info
% Uses:	max_loop, print_loop_nr, simulations_complete
%           enabled_transition
%           start_firing
%           complete_firing
%           global_timer_advancement
%           pack_sim_results
% Used by:	fpensim
% Note:	This is one of the most important M-files, 
%       as it realizes the main simulation loop 
% Example:	
%   % inside fpensim
%   [sim_results, global_info, pn] = timed_pensim(png, global_info);
% 

Ps = pn.No_of_places;      % number of places
Ts = pn.No_of_transitions; % number of tansitions

EIP=[]; % Queue for events_in_progress; initially, no events in Q

%global recording of events
% INITIALLY, [Initial_state, No event, No parent, Start Time, Stop Time] 
LOG = [pn.X, 0, 0, pn.current_time, pn.current_time];  %total size = Ps + 4  
parent_index = 1;  %index into LOG
colormap = [];
Enabled_Trans_SET = []; % Log for global set of enabled trans
Firing_Trans_SET = []; % Log for global set of firing trans

                                    
pn.Firing_Transitions = zeros(1, Ts);  % firing transitions
pn.Enabled_Transitions = zeros(1, Ts); % enabled transitions

SIM_COMPLETE = 0; % simulation is not complete, just for starting 
Loop_Nr = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%  MAIN LOOP   %%%%%%%%%%%%%%%%%%%%%%%%%%
while ~(SIM_COMPLETE),
   Loop_Nr = Loop_Nr + 1; 
   if (pn.PRINT_LOOP_NUMBER),
       disp(['Loop nr:  ', num2str(Loop_Nr)]);
   end;
    
   for i = 1:Ts, 
       pn.Enabled_Transitions(i) = enabled_transition(i,pn); 
   end;    
   Enabled_Trans_SET = [Enabled_Trans_SET;       % ** NOTE: APRIORI **
       pn.current_time,pn.Enabled_Transitions];  % set of enabled trans

   if any(pn.Enabled_Transitions),
       [pn,EIP,global_info] = start_firing(pn,...
           EIP,parent_index,global_info);
   end;
       
   Firing_Trans_SET = [Firing_Trans_SET;        % ** NOTE: APOSTERORI **
       pn.current_time, pn.Firing_Transitions]; % set of firing trans     
    
   % Now take a completed event in queue
   log_record = []; colormap_record=[];
   
   % completes firing; collects records; move the timer
   EIP_not_empty = ~isempty(EIP);
   if (EIP_not_empty),
       [pn, EIP, log_record, colormap_record, global_info] = ...
           complete_firing(pn, EIP, global_info);    
   end;
   
   % NO need to increase timer value if EIP was not empty
   % if EIP was not empty, function 'complete_firing' itself has 
   % already increased the timer value
   if ~(EIP_not_empty),     
        start_time = pn.current_time;
        pn.current_time = pn.current_time + pn.delta_T;
        log_record = [pn.X,0,parent_index,start_time,pn.current_time];
        colormap_record = []; 
    end; % ~(EIP_not_empty),     
    
    LOG = [LOG; log_record]; %recording of events for tracing back
    colormap = [colormap colormap_record];
    parent_index = parent_index+1;
    %stop if ((queue is empty) OR (max loop) OR (max log size)) is reached 
    SIM_COMPLETE = simulations_complete(EIP,pn,LOG,Loop_Nr,pn.MAX_LOOP);                        
end; %while ~(SIM_COMPLETE)

% Finally, pack results 
sim_results = pack_sim_results(pn, ...
    Enabled_Trans_SET, Firing_Trans_SET, LOG, colormap);

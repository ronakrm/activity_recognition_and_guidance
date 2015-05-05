function [STSP] = state_space(Sim_RES)  
% function [stsp] = state_space (Sim_RES)  
% 
Ps = Sim_RES.No_of_places;
Ts = Sim_RES.No_of_transitions;

ETS = Sim_RES.Enabled_Transitions; 
[m_et, n_et] = size(ETS);
FTS = Sim_RES.Firing_Transitions;

LOG = Sim_RES.LOG; [m_log, n_log] = size(LOG);

null_state = zeros(1, Ps);
null_trans = zeros(1, Ts);

STSP = [] ; % init matrix for state_space

i=0;  k=0;

while all([(i < m_et), (k < m_log)]),
    i=i+1; k=k+1;
    finishing_time = ETS(i, 1);
    if ~eq(finishing_time, FTS(i, 1)),
        error('ETS(i, 1) ~= FTS(i, 1)');
    end;
    if ~eq(finishing_time, LOG(k,end)),
        error('ETS(i, 1)~= LOG(k,end)');
    end;
    
    new_state = LOG(k, 1:Ps);
    fired_trans = LOG(k,(end-3));
    log_row = [finishing_time, fired_trans, new_state,  null_trans];
    ets_row = [finishing_time 0  null_state ETS(i, 2:end)];  % 
    fts_row = [finishing_time 0  null_state FTS(i, 2:end)]; % 
    STSP = [STSP; log_row; ets_row; fts_row];
end;

%[time    fired_trans       new_state          null_trans]
%[time        0             null_places            ets   ]
%[time        0             null_places            fts   ]


function print_schedule(sim_results)
% function print_schedule(sim_results)
% For every resource utilized, this fundtion prints
% the transition that used the resource, start time  and end time
% of utilization

res = sim_results.resources;
Rs = length(res.names);

LOG = res.usage_LOG;
[rows, cols] = size(LOG); 

ST = zeros(1, Rs);  % Station Time


% LOG file: [resource    transition    start_time    end_time]   

for current_res = 1:Rs, % no_of_resources,
    st = 0;   % station time used
    disp('  ');
    disp([' *** ', res.names{current_res}, ' ***']);
    
    for i=1:rows,
        if eq(LOG(i,1), current_res),
            % display:  transition name  start_time end_time
            transition_name = sim_results.Transition_Names(LOG(i, 2),:); 
            start_time = LOG(i,3);
            end_time   = LOG(i,4);
            task_time = end_time - start_time;
            st = st + task_time;
            disp([transition_name, ' [', ...
                num2str(start_time), ' : ', ...
                num2str(end_time), ']']);            
        end;
    end;
    ST(current_res) = st;
end;

K = Rs;
CT = max(ST);
LT = K * CT;  
LE = sum(ST)*100/LT;

SI = 0;
for i = 1:Rs, 
    si = CT - ST(i);
    SI = SI + si * si;
end;
SI = sqrt(SI);


    

disp('  ');

disp('  Summary: ');
disp('  ');
disp(['  K = ', num2str(Rs)]);
% disp(['  Station Times: ', num2str(ST)]);
disp(['  LE = ', num2str(LE), ' %']);
disp(['  SI = ', num2str(SI)]);
disp(['  LT = ', num2str(LT)]);

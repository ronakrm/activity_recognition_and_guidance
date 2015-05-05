function [pn] = filecheck_pre_post(pn)
% function [pn] = filecheck_pre_post(pn)


Ts = pn.No_of_transitions;

PRE_exist  = zeros(1, Ts);
POST_exist = zeros(1, Ts);

for ti = 1:Ts,
    tname = pn.global_transitions(ti).name;
    file_pre  = [tname '_pre.m'];
    file_post = [tname '_post.m'];
    
    if exist(file_pre, 'file'),
        PRE_exist(ti) = 1;
    end;
    if exist(file_post, 'file'),
        POST_exist(ti) = 1;
    end;    
end;

pn.PRE_exist = PRE_exist;
pn.POST_exist = POST_exist;
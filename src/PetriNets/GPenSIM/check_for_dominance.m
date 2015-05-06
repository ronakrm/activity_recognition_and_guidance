function [x1] = check_for_dominance(x, COTREE, parent)
%%  [x1] =check_for_dominance(x, COTREE, parent)

No_Places = length(x);

while not(parent==0), 
    Xparent = COTREE(parent, :);
    xp = Xparent(1: No_Places);
    
    if all(ge(x, xp)),          % current tokens greater or equal to parent         
        index_gt = gt(x, xp);   % current tokens greater than parent 
        x(index_gt) = inf;      % let them be inf
    end;
    
    inf_index = eq(xp, inf);    % parent has some inf tokens alreay
    x(inf_index) = inf;          % let them be inf in current too
    
    parent = Xparent(No_Places+2); 
end; % while

x1 = x;
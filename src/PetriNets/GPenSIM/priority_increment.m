function [pn] = priority_increment(pn, trans_name)
% function [pn] = priority_increment(pn, trans_name)


tx = is_trans(pn, trans_name);
if ~(tx), 
    error([trans_name, ' : wrong transition name']);
end;

pn.priority_list(tx) = pn.priority_list(tx) + 1;


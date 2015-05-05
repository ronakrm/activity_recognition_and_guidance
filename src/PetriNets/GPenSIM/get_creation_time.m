function [set_of_creation_time] = get_creation_time (pn, set_of_tokID)
% function [set_of_creation_time] = get_creation_time (pn, set_of_tokID)

length_of_tokIDs = length(set_of_tokID);
no_of_places = length(pn.global_places);
set_of_creation_time  = [];

pj = 1;
while and((pj <= no_of_places), any(set_of_tokID)),
    tbank = pn.global_places(pj).token_bank;
    for kb = 1: length(tbank),
        member_index = ismember(set_of_tokID, tbank(kb).tokID);
        if any(member_index),
            set_of_creation_time = [set_of_creation_time, tbank(kb).creation_time];
            set_of_tokID(member_index)= 0; 
        end;
    end;
    pj = pj + 1;
end;



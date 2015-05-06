function [set_of_tokID] = select_token(pn, placeI, nr_tokens_wanted)
% [set_of_tokID] = select_token(pn, placeI, nr_tokens_wanted)
% function [set_of_tokID] = select_token(pn, placeI, nr_tokens_wanted)

set_of_tokID = [];
if not(nr_tokens_wanted),  % nr_tokens_wanted == 0
    return;
end;

% place is a character string
p_index = search_names(placeI, pn.global_places);
if (p_index),
    placeI = p_index;
else
    error([placeI, ': wrong place name in "select_token"']);
end;    

nr_tokens_in_placeI = pn.global_places(placeI).tokens;
if not(nr_tokens_in_placeI),  % this place has no tokens 
    return;
end;

if (nr_tokens_wanted > nr_tokens_in_placeI),
    nr_tokens_wanted = nr_tokens_in_placeI;  % number of tokens available
end;

token_bank = pn.global_places(placeI).token_bank(1:nr_tokens_wanted);
set_of_tokID = token_bank.tokID;
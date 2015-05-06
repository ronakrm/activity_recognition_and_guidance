function [pn, color_of_del_tokens] = consume_token_in_place_i ...
    (pn,placeI, nr_tokens_to_be_deleted, set_of_tokID)
%
% [pn,color_of_del_tokens] = consume_token_in_place_i ...
%          (pn,placeI,nr_tokens_to_be_deleted,set_of_tokID)
%
%
%
%%%%%%%%%%%%%%%

color_of_del_tokens = {}; % color set of deleted tokens
nr_tokens_in_placeI = pn.global_places(placeI).tokens;
deleted_tokens = 0; % initially
token_bank = pn.global_places(placeI).token_bank;
new_token_bank  = [];

if (nr_tokens_to_be_deleted > nr_tokens_in_placeI), 
    error('Error in "delete_token": (nr_tokens_to_be_deleted > tokens)');
end;

i = 1;
while (any(set_of_tokID) & (i <= nr_tokens_in_placeI) & ...
        (deleted_tokens < nr_tokens_to_be_deleted)),
    member_index = ismember(set_of_tokID, token_bank(i).tokID);
    if any(member_index),
        set_of_tokID(member_index) = 0;
        color_of_del_tokens = union(color_of_del_tokens,...
            token_bank(i).color); % ADD
        deleted_tokens = deleted_tokens + 1;
    else
        new_token_bank  = [new_token_bank token_bank(i)];
    end;
    i=i+1;
end;

% copy rest of the token_bank
new_token_bank = [new_token_bank token_bank(i:nr_tokens_in_placeI)];

% now delete tokens without specific tokID
more_to_delete = nr_tokens_to_be_deleted - deleted_tokens;
if (more_to_delete > 0),
    length_of_new_bank = length(new_token_bank);
    new_token_bank2 = new_token_bank(more_to_delete+1:...
        length_of_new_bank);
    for i=1:more_to_delete,
        color_of_del_tokens = union(color_of_del_tokens, ...
            new_token_bank(i).color);
    end;
else
    new_token_bank2 = new_token_bank;
end;

pn.global_places(placeI).token_bank = new_token_bank2;
pn.global_places(placeI).tokens = length(new_token_bank2);

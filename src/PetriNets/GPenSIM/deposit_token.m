function [pn] = deposit_token(pn, placeI, nr_tokens, t_color)
%% [pn] = deposit_token(pn, placeI, nr_tokens, t_color)
%%
%%%%%%%%%%%%%%%%%%%%%%
nr_places = length(pn.global_places);

pn.global_places(placeI).tokens = ...
    pn.global_places(placeI).tokens + nr_tokens; 

for i = 1:nr_tokens,
    pn.token_serial_numer = pn.token_serial_numer + 1;
    tok.tokID = pn.token_serial_numer;
    tok.creation_time = pn.current_time;
    tok.color = t_color;
    pn.global_places(placeI).token_bank = ...
        [pn.global_places(placeI).token_bank tok];
end;

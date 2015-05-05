function [pn] = init_token_bank(pn)
% [pn] = init_token_bank(pn)
%
%

nr_places = pn.No_of_places;
pn.token_serial_numer = 0;
X = pn.X; % initial state

for i = 1:nr_places,
    pn.global_places(i).token_bank=[];
end;

for i = 1:nr_places,
    if X(i),
        for j=1:X(i),
            pn.token_serial_numer = pn.token_serial_numer + 1;
            tok.tokID = pn.token_serial_numer;
            tok.creation_time = 0;
            tok.color = {};
            pn.global_places(i).token_bank = ...
                [pn.global_places(i).token_bank tok];
        end;
    end;
end;


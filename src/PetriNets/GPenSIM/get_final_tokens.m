function [final_tokens] = get_final_tokens(pn)
% [final_tokens] = get_final_tokens(pn)
%
% keyboard;
final_tokens = [];
for placeI = 1:length(pn.global_places),
    token_bank = pn.global_places(placeI).token_bank;
    if not(isempty(token_bank)),
        lenTB = length(token_bank);
        for tokenJ = 1:lenTB,
            cm.creation_time = token_bank(tokenJ).creation_time;
            cm.place = placeI;
            cm.color = token_bank(tokenJ).color;
            cm.tokID = token_bank(tokenJ).tokID;
            final_tokens = [final_tokens cm];            
        end;
    end;
end;

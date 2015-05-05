function [set_of_tokID,nr_token_av] = select_token_with_colors(pn,...
    placeI, nr_tokens_wanted, t_color)
% function [set_of_tokID,nr_token_av] = select_token_with_color(pn,...
%    placeI, nr_tokens_wanted, t_color)

if ischar(placeI),   % place is a character string
    p_index = search_names(placeI, pn.global_places);
    if (p_index),
        placeI = p_index;
    else
        error([placeI, ':   Wrong place name in "select_token_color"']);
    end;    
end;

nr_tokens_in_placeI = pn.global_places(placeI).tokens;
set_of_tokID = [];
nr_token_av = 0;  % number of tokens available
i = 1;

token_bank = pn.global_places(placeI).token_bank;

while and((nr_token_av < nr_tokens_wanted), ...
        i <= nr_tokens_in_placeI),
    if all(ismember(t_color, token_bank(i).color)),  
        nr_token_av = nr_token_av + 1;
        set_of_tokID = [set_of_tokID token_bank(i).tokID];
    end;
    i=i+1;
end;

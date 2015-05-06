function [colormap_record] = get_current_colors (pn)
% [colormap_record] = get_current_colors (pn)

colormap_record = [];
for placeI = 1:length(pn.global_places),
    token_bank = pn.global_places(placeI).token_bank;
    if not(isempty(token_bank)),
        lenTB = length(token_bank);
        for tokenJ = 1:lenTB,
            if not(isempty(token_bank(tokenJ).color)),
                cm.time = pn.current_time;
                cm.place = placeI;
                cm.color = token_bank(tokenJ).color;
                cm.tokID = token_bank(tokenJ).tokID;
                colormap_record = [colormap_record  cm];
            end;
        end;
    end;
end;

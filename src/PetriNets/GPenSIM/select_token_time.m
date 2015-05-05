function [set_of_tokID] = select_token_time(pn, placeI, ...
    nr_tokens_wanted, FCFS_or_LCFS)
%% [set_of_tokID]=select_token_time(pn,placeI,nr_tokens_wanted,FCFS_or_LCFS)
%%%%%%%%%%%%%%%%%%%%%%
%% function [set_of_tokID] = select_token_time(pn, placeI, ...
%%     nr_tokens_wanted, FCFS_or_LCFS)

if ischar(placeI),   % place is a character string
    p_index = search_names(placeI, pn.global_places);
    if (p_index),
        placeI = p_index;
    else
        error('wrong place name in "select_token_color"');
    end;    
end;

nr_tokens_in_placeI = pn.global_places(placeI).tokens;

if (nr_tokens_wanted <= nr_tokens_in_placeI),
    nr_token_av = nr_tokens_wanted; % number of tokens available
else
    nr_token_av = nr_tokens_in_placeI;
end;

tbank = pn.global_places(placeI).token_bank;
tbank_length = length(tbank);
set_of_tokID = [];

if strcmpi(FCFS_or_LCFS, 'fcfs'),
    i=1;
    while (i <= nr_token_av),
        ftimer = 1.e6;   %%%%% LARGE TIME
        for j=1:tbank_length,
            if (tbank(j).creation_time <= ftimer),
                ftimer = tbank(j).creation_time;
                current_fc = j;
            end;
        end;
        set_of_tokID = [set_of_tokID tbank(current_fc).tokID];
        tbank(current_fc).creation_time = NaN; %%%%% this is already taken
        i = i+1;
    end;
elseif strcmpi(FCFS_or_LCFS, 'lcfs'),
    i=1;
    while (i <= nr_token_av),
        ltimer = -1;   %%%%% HYPOTHETIC MINIMUM TIME
        for j=1:tbank_length,
            if (tbank(j).creation_time >= ltimer),
                ltimer = tbank(j).creation_time;
                current_fc = j;
            end;
        end;
        set_of_tokID = [set_of_tokID tbank(current_fc).tokID];
        tbank(current_fc).creation_time = NaN; %%%%% this is already taken
        i = i+1;
    end;
else
    disp('error: enter FCFS or LCFS to slelct-token-time');
end;

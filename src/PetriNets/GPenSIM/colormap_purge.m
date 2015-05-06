function [purged_colormap] = colormap_purge (colormap)
%% function [new_colormap] = colormap_purge (colormap)
%% the colormap from the function timed_gpensim has 
%% multiple entry for the same tokens. This is because
%% whenever a transtion is enabled (fires or not),
%% colomap records the colors of all existing tokens.
%% 
%% This function 'colormap_purge' removes multiple
%% entries for colors of a token
%%

tokIDs = [colormap.LOG.tokID];
mint = min(tokIDs);  % smallest tokID
maxt = max(tokIDs);  % largest tokID
new_LOG = [];       % make a new LOG of unique token colors

for i = mint:maxt,
    m_index = find(tokIDs == i);
    if ~(m_index),  error(['No tokID: ', num2str(i)]); end;
    
    first_index = m_index(1);
    tok_color = colormap.LOG(first_index);
    new_LOG = [new_LOG tok_color];
    for j = 2:length(m_index),
        [C, I] = setdiff(tok_color.color, colormap.LOG(m_index(j)).color);
        if ~isempty(I),
            error(['same token different color']);
        end;
    end; %for
end; %for

purged_colormap.type = 'color_map';
purged_colormap.LOG = new_LOG;

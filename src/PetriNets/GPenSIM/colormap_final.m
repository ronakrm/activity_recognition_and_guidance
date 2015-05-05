function [final_tokens_colormap] = colormap_final (colormap)
%% function [final_tokens_colormap] = colormap_final (colormap)
%%
%% The colormap from the function 'timed_gpensim' has 
%% entries all the tokens, exisiting and existed.
%%
%% This function returns colors of the final tokens;
%% final tokens are the tokens that exist when simultion
%% is stopped or completed.

final_tokens_LOG = [];
finishing_time = colormap.LOG(end).time;

time_series = [colormap.LOG.time];
final_token_index = find(time_series == finishing_time);
for i = 1:length(final_token_index),
    m_index = final_token_index(i);
    final_tokens_LOG = [final_tokens_LOG colormap.LOG(m_index)];
end;

final_tokens_colormap.type = 'color_map';
final_tokens_colormap.LOG = final_tokens_LOG;

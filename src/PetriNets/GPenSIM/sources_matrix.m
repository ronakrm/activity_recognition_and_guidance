function [sources_m] = sources_matrix(global_places, sources)
%% [sources_m] = sources_matrix(global_places, sources)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function sources_m = sources_matrix(pn.global_places, sources)
no_sources = length(sources)/2;
sources_m = zeros(1, length(global_places));

for i=1:no_sources,
    curr_place = sources{2*i -1};
    place_nr = search_names(curr_place, global_places);
    sources_m(1, place_nr)=sources{2*i};
end;
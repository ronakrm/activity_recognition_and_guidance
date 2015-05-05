function [X, pn] = intial_marking(pn, sources); % intial marking
% X = elements_matrix(global_elements, elements)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This function extracts a group of elements from a given inputs of
%%global_elements and elements. The resulting output is an element matrix.
%%function elements_m = elements_matrix(pn.global_elements, elements)
%%Inputs:
%       -global elements
%      - elements
%%Output: elemets matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

no_of_sources = length(sources)/2; %number of elements to be extracted
%allocate empty matrix for accomodating elements extracted

X = zeros(1, pn.No_of_places); 

% extracting elements
%check whether the current elements is a member of global_elements
%%sett in extracted element in the allocted matrix
for i=1:no_of_sources,
    curr_source_name = sources{2*i -1};
    source_nr = search_names(curr_source_name, pn.global_places); 
    % assign initial tokens to place
    if (source_nr==0), %wrong names
        error([curr_source_name, ': No such place name']);
    end;
    pn.global_places(source_nr).tokens = sources{2*i};  
    X(1, source_nr) = sources{2*i};       
end;


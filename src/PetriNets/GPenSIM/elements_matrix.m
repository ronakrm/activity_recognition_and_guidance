function elements_m = elements_matrix(global_elements, elements)
%% [elements_m] = elements_matrix(global_elements, elements)
%%This function extracts a group of elements from a given inputs of
%%global_elements and elements. The resulting output is an element matrix.
%%function elements_m = elements_matrix(pn.global_elements, elements)
%%Inputs:
%%       -global elements
%%      - elements
%%Output: elemets matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
no_of_elements = length(elements)/2; %number of elements to be extracted
%allocate empty matrix for accomodating elements extracted
elements_m = zeros(1, length(global_elements)); 
%% extracting elements
%check whether the current elements is a member of global_elements
%%sett in extracted element in the allocted matrix
for i=1:no_of_elements,
    curr_element = elements{2*i -1};
    element_nr = search_names(curr_element.name, global_elements); 
    elements_m(1, element_nr) = elements{2*i};   
end;

    
    

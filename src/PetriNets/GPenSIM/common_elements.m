function [common_elts] = common_elements(sys1, sys2)
%% [common_elts] = common_elements(sys1, sys2)
%% Inputs: Sys1, Sys2 - input systems 
%% Outputs: common_elts - common elements in both Sys1 & Sy2
%%    Two rows are returned, row1 - indices of common elements
%%    in sys1, and row2 - indices of common elements in sys2
%% Example:
%%   [common_elts] = common_elements(sys1, sys2)
%%
%% Explanation: To find common elements in both Sys1 and Sys2
%%
%% Relevant theory: 
%% Uses: search_names
%% Used by: (many)
%% Last update:	rd@hin.no, 26.02.00
%%

common_elts = []; %elements common to sys1 and sys2.

for i=1:size(sys1.elements, 2), %nr. of elements   
   %search for element 
   elt_nr = search_names(sys1.elements(i).name, sys2); 
   if elt_nr, %element found
      elts = [i; elt_nr];
      common_elts = [common_elts elts];
   end;
end;

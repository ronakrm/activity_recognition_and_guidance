function [element_nr] = search_names(name, Sys1)
%% [element_nr] = search_names(name, Sys1)
%% This function find the index (indices) of 
%% an element (name) within a system. If element is 
%% not found within system, then 0 is returned.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Function name: SEARCH_NAMES   (SEARCH NAMES)
%% Inputs: name of variable and the system to be searched
%% Outputs: [element_number] the index of name within system
%% Example:
%%   [element_nr] = search_names('ALARM', SYS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

element_nr = []; % element not found yet 

for i=1:size(Sys1,2), %number of elements in system
   if strcmp(name, Sys1(i).name), %compare names
      element_nr = [element_nr i];
   end; %if strcmp
end; %for i=

%if element is not found 
if isempty(element_nr), element_nr = 0; end;


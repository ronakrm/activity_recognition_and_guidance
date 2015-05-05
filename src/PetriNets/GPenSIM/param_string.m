function [STRING] = param_string(numbers, Str_in)
%% [STRING] = param_string(numbers, Str_in)
%
%
STRING = []; %empty initial string

for i=1:length(numbers),
   STRING = [STRING, Str_in, int2str(numbers(i)),','];
end; 

STRING = STRING(1:end-1); %remove the last comma

function [Output_Set] = randomgen(Input_Set)
% [Output_Set] = randomgen(Input_Set)
% This function randomly rearranges the input set 
% 
% E.g. ns = randomgen([1:10])
% ns = [4     6     3     1    10     8     9     5     7     2]
%

Ts = length(Input_Set); % init vector 

for i = 1:Ts,
    j = round(rand(1)*Ts); %incl 0 and Ts
    if (j), 
        temp = Input_Set(i);
        Input_Set(i) = Input_Set(j);
        Input_Set(j) = temp;
    end;
end;

Output_Set = Input_Set;

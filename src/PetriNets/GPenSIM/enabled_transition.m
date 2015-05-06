function [Results] = enabled_transition(t,pn) 
% [Results] = enabled_transition(t,pn) 
%This function checks whether a given transition is enabled or not.That
%means to se if all the preconditions for given transition to fire or to
%to happen are in place.
%function [Results]= enabled_transition(t,A,X) 
%Inputs:
%       t - transition
% Outputs: Results(logical one or null)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ischar(t),
    t = get_trans(pn, t); %if t is name then convert into number
end;

A = pn.incidence_matrix;
X = pn.X;
Ps=size(A,2)/2; %number of places

%first check for orphan transitions; 
Places=A(t,:);

if any(Places), %this is not orphan transition
   input_place=A(t,1:Ps); %input places for transition t
   % check if there are non_ zero numbers along the input place array
   index_IP = any(input_place,1); %index of input place
   
   %input arcs extending from input places to a given transition
   input_arcs = input_place(index_IP); 
   input_tokens = X(index_IP); %tokens in input places

   % check if all input tokens er greater than or equal all corresponding-
   % input arcs
   % only when all input tokens are greater than or equal to the input-
   % arcs is a given transition is enabled
   Results = all(ge(input_tokens, input_arcs));
else  %now treat for an orphan t
   Results=0; %unabled transition
end; %if any(Places)

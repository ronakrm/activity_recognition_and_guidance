function [pn,delta_X,index_OP,inherited_color_set] = consume_tokens...
    (pn, transition, selected_tokID)
% [pn,delta_X,index_OP,inherited_color_set] = consume_tokens...
%                              (pn,trans,selected_tokID)
% This function takes care of removing tokens from input places and 
% computing deposits on the output place when an enabled transition fires.
%
% Inputs:     transition - a given transtion 
%             X: intial marking (state of system at any given time)
% Outputs:    X: number of tokens remaining at the input place after-
%                       removal of token
%             delta_X:  weight output arcs;  
%             index_op: index of output places
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ps = length(pn.global_places); % number of places
A = pn.incidence_matrix; 

%token removals from input place
input_places=A(transition,1:Ps); %extracting the weight of input arcs 
inherited_color_set = {};

pn.X = pn.X - input_places; %removing tokens
for i=1:length(pn.global_places),
    tokens_to_be_consumed = input_places(i);
    if tokens_to_be_consumed,
        [pn, inherited_color_from_pi] = consume_token_in_place_i ...
            (pn,i, tokens_to_be_consumed, selected_tokID); 
        % inherit colors from different places 
        inherited_color_set = union(inherited_color_set, ...
            inherited_color_from_pi);        
    end;
end;

output_places = A(transition,Ps+1:2*Ps); %extracting output arc weights
index_OP=any(output_places,1); %index of output place
delta_X = output_places;  % tokens to be deposited into output places

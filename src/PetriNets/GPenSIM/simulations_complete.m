function [SIM_COMPLETE] =  simulations_complete (EIP, pn, LOG, ...
                            Loop_Nr, MAX_LOOP)
% [SIM_COMPLETE] =  simulations_complete(EIP, pn, LOG,...
%                          Loop_Nr, MAX_LOOP)
% This function determines whether to terminate simulations

Queue_is_Empty = isempty(EIP);
No_enabled_transitions = ~any(any_enabled_transitions(pn));
Que_is_Empty_and_No_enabled_Transitions = and(Queue_is_Empty, ...
                                No_enabled_transitions);                 
Max_Loop_Number_Reached = ge(Loop_Nr, MAX_LOOP); 


SIM_COMPLETE = or(Que_is_Empty_and_No_enabled_Transitions, ...
                Max_Loop_Number_Reached);

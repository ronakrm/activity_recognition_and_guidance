function sys = connection (set_of_arcs, sys_name)
%% [sys] = connection(set_of_arcs, sys_name); 
%%
%% This function creates a Petri net (system) by combining all 
%% the transisitions. It is converting the graphical format of 
%% a petri net modell in to matrix format(incidence-matrix).
%% The inputs for connect function are the set of transitions 
%% and finally  the name of the system. 
%% With in transitions we can find out places since every 
%% transitions has an input and output places.Transition is 
%% also containing other informations such as firing time and cost. 
%% The main output of this function is an incidence_matrix which is
%% very vital for simulation of our petri net model.
%%
%%    Inputs: : a1..aLast-1    : arcs
%%            :ivLast          : name of the system  
%%       
%%    Output: sys is a data structure, it is possible to extract 
%%       spesific data from it (eg. sys.incidence_matrix = A;)
%%
%%    Functions called: search_names

%%          RD 10.february.2006  (Comments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% check whether the last argument is the name
%% and get the number of arcs input
if nargin==1, % name/label for the petri net is not given 
    sys.name = strcat('A Petri Net ',  num2str(round(rand*50))); % A random name
else
    sys.name = sys_name;
end;
    
%% declare global_transitions
%% declare global_places
%% declare global_arcs
global_transitions = [];
global_places = [];
global_arcs = [];
no_arcs = length(set_of_arcs); % number of arcs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN LOOP - 1
%% extract info from the arcs and put the info
%% on 'global_places' and 'global_transitions'

for i=1:no_arcs, %number of transition
    curr_arc = set_of_arcs(i); 
    %% first, check if the curr_ transtion is not in 
    %% the global_ transition list and add the transition 
    %% to the global_ transition list
    global_arcs = [global_arcs curr_arc];
    
    %% second, extract input_places from curr_transition
    %% check if input_place is not in the global-places 
    %% and then add in the global_places list    
    from_element = curr_arc.from;
    to_element = curr_arc.to;
    if strcmp(from_element.type, to_element.type),
        error(['Same type of elements: ', from_element.name, ...
            to_element.name]);  %create error message
    end;
    
    if strcmp(from_element.type, 'place'), %this arc is from a place
        if ~(search_names(from_element.name, global_places)),
            global_places = [global_places from_element];
        end;
        if ~(search_names(to_element.name, global_transitions)),
            global_transitions = [global_transitions to_element];
        end;
    else  % the arc is from a transition
        if ~(search_names(from_element.name, global_transitions)),
            global_transitions = [global_transitions from_element];
        end;
        if ~(search_names(to_element.name, global_places)),
            global_places = [global_places to_element];
        end;
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN LOOP - 2
%% constructing the the incidence_matrix (A)
no_transitions = length(global_transitions);
no_places = length(global_places);
no_arcs = length(global_arcs);
%% declare empty matrix with row==no of transitions and column== twice the
%% number of places
A = zeros(no_transitions, 2*no_places);

for i=1:no_arcs, %number of transition
    curr_arc = global_arcs(i);
    from_element = curr_arc.from;
    to_element = curr_arc.to;
    w = curr_arc.weight;
    if strcmp(from_element.type, 'place'), %this arc is from a place
        p = search_names(from_element.name, global_places);
        t = search_names(to_element.name, global_transitions);
        A(t, p) = w; %fill in the incidence_matrix
    else % this arc is from a transition
        p = search_names(to_element.name, global_places);
        t = search_names(from_element.name, global_transitions);
        A(t, p+no_places) = w; %fill in the incidence_matrix
    end;
end;

%% out put of conncet funtion
%% extract spesific information of interest
sys.global_places = global_places;
sys.global_transitions = global_transitions;
sys.global_arcs = global_arcs;
sys.incidence_matrix = A;

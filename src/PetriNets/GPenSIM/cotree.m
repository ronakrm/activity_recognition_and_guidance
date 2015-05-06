function [cotree_results] = cotree(pn, initial_markings)   
% [cotree_results] = cotree(pn, initial_markings)   
% Name:	cotree
% Purpose:	Creates the coverability tree of a Petri net 
% Input parameters:	Static Petri net sturcture (output by ‘petrinetgraph’)
%                   Intial_markings
% Out parameters:	Cotree structure 
% Uses:	sources_matrix, enabled_transition, new_marking, 
%       check_for_dominance, good_name
% Used by:	[main simulation file]
% NOTE:	Cotree algorithm is similar to Cassandras & Lafortune (1998)
%
% Example:	
%   % in main simulation file
%   png = petrinetgraph('cotree_example_def');
%   dyn.initial_markings = {'p1',2, 'p4', 1};
%   cotree_sturcture = cotree(png, dyn.initial_markings);
%   print_cotree(cotree_sturcture);


%   Revised RD on 06 sep 2006 

% first extract the initial markings from the initial dynamics

if isstruct(initial_markings),
    sources = initial_markings.initial_markings;
else
    sources = initial_markings;
end;

pn.X = sources_matrix(pn.global_places, sources); %initial state

FALSE = 0;  TRUE = 1;	
Ps = length(pn.global_places);	% number of places
Ts = length(pn.global_transitions); % number of transitions

COTREE = zeros(1, Ps+3); % initialize COTREE
COTREE(1, 1:Ps) = pn.X;     % initialize COTREE with x
%%%%%%%%%%%%%%%%% info %%%%%%%%%%%%%%% 
%%%% COTREE(i,Ps+1) is triggering transition that created the 'i'th row 
%%%% COTREE(i,Ps+2) is the parent row of the 'i'th row  
%%%% COTREE(i,Ps+3) is a tag: 'R'oot/'D'uplicate/'T'erminal 
COTREE(1, Ps+3) = double('R');%'R'oot; also the first row
main_index = 0; 

%global while loop
while lt(main_index, size(COTREE,1)),
   main_index = main_index+1;
   X = COTREE(main_index, :); % current state (with extended info)
   pn.X = X(1:Ps); % current state 
   
   %check for duplicate
   xTREE = COTREE(1:main_index-1, 1:Ps);   % reachable states from x
   parent = X(Ps+2); 
   if ~any(ismember(xTREE, pn.X, 'rows')),%not duplicate
      
      terminal = TRUE; % for starting
      for t = 1:Ts,
         if enabled_transition(t, pn), 
            terminal = FALSE; %enabled trans means not terminal
            new_branch = zeros(1, Ps+3); %new branch
            
            x1 = new_marking(t, pn); %STEPS 2.2 + 2.2.1
            %STEP 2.2.2
            x1 = check_for_dominance(x1, COTREE(1:main_index-1, :), parent);
            new_branch(1, 1:Ps) = x1; 
            new_branch(1, Ps+1) = t;
            new_branch(1, Ps+2) = main_index; 
            COTREE=[COTREE; new_branch];
         end; %if enabled_transition
      end; %for t=1:Ts
      
      if terminal,
         COTREE(main_index, Ps+3) = double('T'); %'T'erminal
      end; %if terminal,
      
   else  %if ~any(ismember(XTREE, X
      COTREE(main_index, Ps+3) = double('D'); %'D'uplicate
   end; %if ~any(ismember(XTREE, X, 
end; %global while 

% pack results 
cotree_results.type = 'COTREE'; 
cotree_results.LOG = COTREE;

PNames = []; TNames = [];
for i=1:Ps, PNames=[PNames; good_name(pn.global_places(i).name)]; end;
for i=1:Ts, TNames=[TNames; good_name(pn.global_transitions(i).name)];end;

cotree_results.Place_Names = PNames; 
cotree_results.Transition_Names = TNames; 

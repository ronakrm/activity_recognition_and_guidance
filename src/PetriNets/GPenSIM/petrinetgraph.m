function [PN]=petrinetgraph(fileNames, global_info) 
% [PN] = petrinetgraph(set_of_files)
%
% E.g.: PN = petrinetgraph({'test0506_def'});
%
% This function reads the petri net definition file(s), which
% is identified by the input filename. Then, it creates 
% the structure for the Petri net.
%
% Define variables: 
% Inputs: PN_def_filename(s)
%
% Output: PN: The Petri net structure
%         
% Functions called : build_place, build_trans, build_arcs, 
%                    incidencematrix 
%                      
 
%  RD 06. August 2008 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%run the definition file
global_set_of_Ps = {};  % all places
global_set_of_Ts = {};  % all transitions
global_set_of_As = {};  % all arcs

%%%% for single definition file %%%%%
if ischar(fileNames), fileNames={fileNames}; end;

No_of_files = length(fileNames);
for i=1:No_of_files,
    funcname = char(fileNames(i)); 
    filename = [funcname '.m'];
    if ~exist(filename, 'file'),  % wrong definition file
        disp([filename ' does not exist...']);
        return
    end;
    if nargin==1,
        [PNname, set_of_Ps, set_of_Ts, set_of_As] ...
            = feval(str2func(funcname));
    elseif nargin==2,
        [PNname, set_of_Ps, set_of_Ts, set_of_As] ...
            = feval(str2func(funcname), global_info);    
    end;
    
    global_set_of_Ps = [global_set_of_Ps set_of_Ps];
    global_set_of_Ts = [global_set_of_Ts set_of_Ts];
    global_set_of_As = [global_set_of_As set_of_As];
end;

global_set_of_Ps = unique(global_set_of_Ps);
global_set_of_Ts = unique(global_set_of_Ts); 

PN.global_places = build_places(unique(global_set_of_Ps));
PN.No_of_places = length(PN.global_places);
PN.global_transitions = build_trans(global_set_of_Ts);
PN.No_of_transitions = length(PN.global_transitions);

PN.global_arcs = build_arcs(PN, global_set_of_As);
PN.name = PNname;
PN.incidence_matrix = incidencematrix(PN);

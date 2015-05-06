function [global_arcs] = build_arcs(PN, set_of_arcs)
% [global_arcs] = build_arcs(PN, set_of_arcs)

%%% treating set_of_arcs
no_of_arcs = length(set_of_arcs)/3; %number of elements to be extracted

global_arcs = []; 
% extracting elements
for i=1:no_of_arcs,
    %find source
    curr_arc_source_name = set_of_arcs{3*i - 2};
    if is_place(PN, curr_arc_source_name),
        curr_arc_source = get_place(PN, curr_arc_source_name);
    elseif is_trans(PN, curr_arc_source_name),
        curr_arc_source = get_trans(PN, curr_arc_source_name);
    else 
        %disp(' **** WARNING ****:');
        error([curr_arc_source_name,'    ---- no such element ']);
    end;
    
    %find destination
    curr_arc_dest_name = set_of_arcs{3*i - 1};
    if is_place(PN, curr_arc_dest_name),
        curr_arc_dest = get_place(PN, curr_arc_dest_name);
    elseif is_trans(PN, curr_arc_dest_name),
        curr_arc_dest = get_trans(PN, curr_arc_dest_name);
    else
        %disp(' **** WARNING ****:');
        error([curr_arc_dest_name, '    ----  no such element ']);
    end;    
    
    curr_arc_weight = set_of_arcs{3*i};
    curr_arc = arc(curr_arc_source, curr_arc_dest, curr_arc_weight);
    global_arcs = [global_arcs curr_arc];
end;

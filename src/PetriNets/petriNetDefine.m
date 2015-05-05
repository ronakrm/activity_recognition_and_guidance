function [petri_net_name, places, transitions, arcs] = petriNetDefine()
%   Defines a base Petri Net for the implementation
%
%   Outputs:
%       petri_net_name - the name of the Petri Net
%       places - the set of places in the Petri Net
%       transitions - the set of transitions in the Petri Net
%       arcs - the set of arcs in the Petri Net

    % initialize Petri Net parameters
    petri_net_name = 'Action Recognition Petri Net';
    places = {'Remove Electronic Display', 'Unscrew First Hand Grip',  ...
        'Unscrew Second Hand Grip', 'Attach Drill Head', ...
        'Remove First Step', 'Remove Second Step', 'Remove Knob', ...
        'Remove Wheel'};
    transitions = {'RED-UFHG', 'RED-USHG', 'UFHG-ADH', 'USHG-ADH', ...
       'ADH-RFS', 'ADH-RSS', 'RFS-RK', 'RSS-RK', 'RK-RW', 'RW-RED'}; 
    arcs = {'Remove Electronic Display', 'RED-UFHG', 1, ...
            'Remove Electronic Display', 'RED-USHG', 1, ...
            'Unscrew First Hand Grip', 'UFHG-ADH', 2, ...
            'Unscrew Second Hand Grip', 'USHG-ADH', 2, ...
            'Attach Drill Head', 'ADH-RFS', 5, ...
            'Attach Drill Head', 'ADH-RSS', 5, ...
            'Remove First Step', 'RFS-RK', 6, ...
            'Remove Second Step', 'RSS-RK', 6, ...
            'Remove Knob', 'RK-RW', 13, ...
            'Remove Wheel', 'RW-RED', 14};

end


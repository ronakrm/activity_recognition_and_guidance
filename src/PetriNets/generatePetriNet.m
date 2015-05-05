function [png] = createPetriNet()
%    Generates a Petri Net model
%
%   Outputs:
%       png - a Petri Net graph model

    % generate the Petri Net graph
    png = petrinetgraph('petriNetDefine');

end


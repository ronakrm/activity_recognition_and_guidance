function [ output_args ] = updatePetriNet(petriNet, currentPlace, action)
%   Updates the Petri Net based on the recognized action
%
%   Inputs:
%       petriNet - the Petri Net structure
%       currentPlace - the current place in the Petri Net
%       action - the recognized action used to update the Petri Net
    
    switch action
        case 1
            if(currentPlace == action)
                pn = deposit_token(petriNet,
            end
        case 2
            
        case 3
            
        case 4
            
        case 5
            
        case 6
           
        case 7
            
        case 8
            
        otherwise
            
    end
    
end


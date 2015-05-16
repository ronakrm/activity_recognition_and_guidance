function [fire, PN, new_color,override,selected_tokens,global_info] = ...
   RS_RK_pre(PN, new_color,override,selected_tokens,global_info)

    % flags for detecting both actions
    global removeFirstStep;
    global removeSecondStep;

    % import the action likelihoods
    global actions;
    
    % initialize weights
    weights = ones(8,1);
    
    % update likelihoods and apply weights
    likelihoods(1) = actions.removeElectronicDisplay;
    likelihoods(2) = actions.unscrewFirstHandGrip;
    likelihoods(3) = actions.unscrewSecondHandGrip;
    likelihoods(4) = actions.attachDrillHead;
    likelihoods(5) = actions.removeFirstStep;
    likelihoods(6) = actions.removeSecondStep;
    likelihoods(7) = actions.removeKnob;
    likelihoods(8) = actions.removeWheel;
    
    % set weights to expected actions
    if(removeFirstStep == 0)
        weights(5) = 0.98;
    end
    if(removeSecondStep == 0)
        weights(6) = 0.98;    
    end
    
    % apply all weights
    likelihoods = likelihoods.*weights';
    
    % obtain maximum likelihood
    [max_likelihood, max_index] = max(likelihoods);
    
    % if the correct action is detected
    if(max_index == 5)
        removeFirstStep = 1;
    end
    if(max_index == 6)
        removeSecondStep = 1;
    end

    % if both actions are satisfied, fire the transition
    if(removeFirstStep == 1 && removeSecondStep == 1)
        fire = 1;
    else
        fire = 0;
    end

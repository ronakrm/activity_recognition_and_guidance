function [fire, PN, new_color,override,selected_tokens,global_info] = ...
   UHG_ADH_pre(PN, new_color,override,selected_tokens,global_info)

    % flags for detecting both actions
    global unscrewFirstHandGrip;
    global unscrewSecondHandGrip;

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
    if(unscrewFirstHandGrip == 0)
        weights(2) = 0.98;
    end
    if(unscrewSecondHandGrip == 0)
        weights(3) = 0.98;    
    end
    
    % apply all weights
    likelihoods = likelihoods.*weights';
    
    % obtain maximum likelihood
    [max_likelihood, max_index] = max(likelihoods);
    
    % if the correct action is detected
    if(max_index == 2)
        unscrewFirstHandGrip = 1;
    end
    if(max_index == 3)
        unscrewSecondHandGrip = 1;
    end

    % if both actions are satisfied, fire the transition
    if(unscrewFirstHandGrip == 1 && unscrewSecondHandGrip == 1)
        fire = 1;
    else
        fire = 0;
    end

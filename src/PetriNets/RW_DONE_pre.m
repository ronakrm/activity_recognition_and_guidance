function [fire, PN, new_color,override,selected_tokens,global_info] = ...
   RW_DONE_pre(PN, new_color,override,selected_tokens,global_info)
    
    % import the action likelihoods
    global actions;
    
    % set weights for expected action
    weights = ones(8,1);
    weights(8) = 0.98;
    
    % update likelihoods and apply weights
    likelihoods(1) = actions.removeElectronicDisplay;
    likelihoods(2) = actions.unscrewFirstHandGrip;
    likelihoods(3) = actions.unscrewSecondHandGrip;
    likelihoods(4) = actions.attachDrillHead;
    likelihoods(5) = actions.removeFirstStep;
    likelihoods(6) = actions.removeSecondStep;
    likelihoods(7) = actions.removeKnob;
    likelihoods(8) = actions.removeWheel;
    
    likelihoods = likelihoods.*weights';
    
    % obtain maximum likelihood
    [max_likelihood, max_index] = max(likelihoods);
    
    % fire the transition if the action is detected
    if(max_index == 8)
        fire = 1;
    else
        fire = 0;
    end
%% Grid search over parameters for pipeline after flow features have been calculated elsewhere.


%% THESE ARE ALSO CODED INTO crossValidation!! Make sure to change there
% also!
numVideos = 30;
numActions = 8;

%%
outputfile = {'numHoofBins', 'numSymbols', 'numStates', '1','2','3','4','5','6','7','8','acc'};
counter = 2;

for numHoofBins = 30
    % generate your hoofs
    disp('generating hoof features.');
    hoofgen(numVideos, numActions, numHoofBins);
    fprintf('hoof features generated.\n');
    for numSymbols = 65:20:145
        for numStates = 24:6:27
            [accuracy, actionAccuracies] = crossValidation(...
                numHoofBins, numStates, numSymbols, 500);
            
            outputfile(counter,1:3) = {numHoofBins, numSymbols, numStates};
            outputfile(counter,12) = {accuracy};
            for i = 4:11
                outputfile(counter,i) = {actionAccuracies(i-3)};
            end
            
            counter = counter + 1;
            save('outputs.mat', 'outputfile');
        end
    end
end

save('outputs.mat', 'outputfile');

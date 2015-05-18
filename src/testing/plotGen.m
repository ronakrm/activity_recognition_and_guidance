%% Generate Plots of Results from Grid Search
% before are the results without the Petri Net Thresholding
% after are the results with the Petri Net Thresholding
before = cell2mat(before(2:size(before,1),:));
after = cell2mat(after(2:size(after,1),:));

% plot numHoofBins vs total accuracy
% figure;
% hold on;
% scatter(before(:,1),before(:,12));
% scatter(after(:,1)),after(:,12)));
% plt(before(:,1)),mean(before(:,12))));
% plot(after(:,1)),mean(after(:,12))));
% 
% title('Number of HOOF bins vs. Total Accuracy');
% legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');
% xlabel('Number of HOOF Bins');
% ylabel('Average Class Accuracy');
% hold off;

% plot numSymbols vs total accuracy
figure;
hold on;
scatter(before(:,2),before(:,12));
scatter(after(:,2),after(:,12));
%legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');

symbsCol = before(:,2);
symbs = unique(symbsCol);
bmymeans = zeros(size(symbs));
amymeans = zeros(size(symbs));
for i = 1:size(symbs)
    bmymeans(i) = mean(before(symbsCol == symbs(i),12));
    amymeans(i) = mean(after(symbsCol == symbs(i),12));
end
plot(symbs,bmymeans,'b');
plot(symbs,amymeans,'r');
legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets','Average Without', 'Average With');
%title('Codebook Size vs. Total Accuracy');

xlabel('Number of Clusters/Symbols');
ylabel('Average Class Accuracy');
hold off;

% plot numStates vs total accuracy
figure;
hold on;
scatter(before(:,3),before(:,12));
scatter(after(:,3),after(:,12));
%legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');

stateCol = before(:,3);
states = unique(stateCol);
bmymeans = zeros(size(states));
amymeans = zeros(size(states));
for i = 1:size(states)
    bmymeans(i) = mean(before(stateCol == states(i),12));
    amymeans(i) = mean(after(stateCol == states(i),12));
end
plot(states,bmymeans,'b');
plot(states,amymeans,'r');
legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets','Average Without', 'Average With');

%title('Number of internal HMM States vs. Total Accuracy');
xlabel('Number of internal HMM States');
ylabel('Average Class Accuracy');
hold off;

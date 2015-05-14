% load mat file without petri/threshold
%load('');

%before = before(2:size(before,1),:);

% load mat file with petri/threshold
%load('');

% plot numHoofBins vs total accuracy
figure;
hold on;
scatter(cell2mat(before(:,1)),cell2mat(before(:,12)));
%plot(after(:,1),after(:,12));
title('Number of HOOF bins vs. Total Accuracy');
legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');
xlabel('Number of HOOF Bins');
ylabel('Average Class Accuracy');
hold off;

% plot numSymbols vs total accuracy
figure;
hold on;
scatter(cell2mat(before(:,2)),cell2mat(before(:,12)));
%plot(after(:,2),after(:,12));
title('Codebook Size vs. Total Accuracy');
legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');
xlabel('Number of Clusters/Symbols');
ylabel('Average Class Accuracy');
hold off;

% plot numStates vs total accuracy
figure;
hold on;
scatter(cell2mat(before(:,3)),cell2mat(before(:,12)));
%plot(after(:,3),after(:,12));
title('Number of internal HMM States vs. Total Accuracy');
legend('Without Thresholding/Petri Nets', 'With Thresholding/Petri Nets');
xlabel('Number of internal HMM States');
ylabel('Average Class Accuracy');
hold off;

% Evaluate the model using cross validation on the training set. 
function [accuracy, confusion_matrix, time_seconds] = ...
    crossValidate(mode, n_fold)
addpath('Whitening', 'Scanning', 'Preprocessing', 'Metrics', ...
        'Feature_Extraction');

% Only use the first 20 data points from each class. To increase speed of
% prototyping and debugging.
QUICK_AND_DIRTY = true;      
      
tic;

[training_labels, training_features] = ...
    createTrainingData(mode, QUICK_AND_DIRTY);
[training_features, ~] = whiten(training_features, []);
                 
disp('Cross-Validating SVM...');
[predictions, ground_truth] = ...
    crossPredict(training_labels, training_features, n_fold);
accuracy = calculateAccuracy(ground_truth, predictions) * 100;
confusion_matrix = confusionmat(ground_truth, predictions);

time_seconds = toc;
disp('Done!');

rmpath('Whitening', 'Scanning', 'Preprocessing', 'Metrics', ...
       'Feature_Extraction');
end
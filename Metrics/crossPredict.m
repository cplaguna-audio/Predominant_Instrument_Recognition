
function [predictions, sorted_labels] = crossPredict(labels, features, n_fold)

predictions = [];
sorted_labels = [];

% Proportional distributions of classes among folds.
folds = cvpartition(labels, 'KFold', n_fold);

% Evaluate one fold at a time.
for (fold = 1:n_fold)
  % Grab the test data.
  test_indices = folds.test(fold);
  test_labels = labels(test_indices, :);
  test_features = features(test_indices, :);
  
  % Get train data.
  train_indices = folds.training(fold);
  train_labels = labels(train_indices, :);
  train_features = features(train_indices, :);
  
  % Train the classifier and get predictions for the current fold.
  svm = svmtrain(train_labels, train_features, '-t 0');
  cur_predictions = svmpredict(test_labels, test_features, svm);
   
  predictions = [predictions; cur_predictions];
  sorted_labels = [sorted_labels; test_labels];
end

end
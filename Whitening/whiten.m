% Whiten data by subtracting the mean and dividing by the standard 
% deviation. Mean and standard deviation are computed from the training
% data but whitening is applied to both the trianing and the test data.
function [white_train, white_test] = whiten(train, test)

num_train_features = size(train, 2);
num_train_data = size(train,1);
num_test_data = size(test,1);

white_train = zeros(num_train_data, num_train_features);
white_test = zeros(num_test_data, num_train_features);

for (feature_idx = 1:num_train_features)
  feature_mean = mean(train(:, feature_idx));
  feature_sdv = std(train(:, feature_idx));
  
  if(feature_sdv == 0) 
    feature_sdv = 1;
  end
  
  white_train(:,feature_idx) = (train(:, feature_idx) - feature_mean) / ...
                               feature_sdv;
  if(~isempty(test))
    white_test(:,feature_idx) = (test(:, feature_idx) - feature_mean) / ...
                                feature_sdv;
  end
end

end

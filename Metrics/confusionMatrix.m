
function confusion = confusionMatrix(predictions, ground_truth)

N = size(predictions, 1);

if(size(ground_truth,1) ~= N)
  disp('Must have same the number of predictions and ground truth.');
end

count_correct = 0;

for(i=1:N)
  if(predictions(i) == ground_truth(i))
    count_correct = count_correct + 1;
  end
end

confusion = count_correct / N;
end
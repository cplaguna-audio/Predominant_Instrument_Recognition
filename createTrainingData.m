% Reads the IRMAS dataset into an N x M matrix where rows are feature 
% vectors and a corresponding N x 1 vector of labels. A convenience
% function that reads in audio data, preprocesses it, extracts features.
% Supports modes for baseline and novel approaches.
function [training_labels, training_features] = ...
    createTrainingData(mode, QUICK_AND_DIRTY)

% Constants.
TRAINING_DATA_PATH = '../datasets/IRMAS/IRMAS-TrainingData/';

training_labels = [];
training_features = [];

% Tasks necessary for both baseline and novel algorithms.
disp('Scanning directories for file paths, labels, and metadata.');
[audio_filenames, training_labels] = ...
    scanIRMASTrainingData(TRAINING_DATA_PATH, QUICK_AND_DIRTY);
num_data = size(training_labels,1);

% New algorithm.
if (strcmp(mode, 'novel'))
  % Create training data for the novel approach.

% Baseline algorithm just uses MFCC's.
elseif (strcmp(mode, 'baseline'))
  disp('Extracting baseline features.');
  
  % Get a row at a time.
  for(i=1:num_data)
    % Display progress.
    if(mod(i,20) == 0)
      disp(strcat(num2str(i), ' completed...'));
    end

    [signal, Fs] = audioread(audio_filenames{i});
    mono_signal = signal(:,1) + signal(:,2);
    training_features = ...
        [training_features; extractFeatures(mono_signal, Fs, mode)];
  end
else
  disp('You must select either the baseline or novel algorithm.');
end

disp('Done loading training data.');
  
end
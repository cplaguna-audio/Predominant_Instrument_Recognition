% Extract a feature vector from an audio signal.
function features = extractFeatures(audio, Fs, mode)

  if (strcmp(mode, 'novel'))
    % Extract features for the novel approach.
  elseif (strcmp(mode, 'baseline'))
    features = extractACAFeatures(audio, Fs);
  else
    disp('You must select either the baseline or novel algorithm.');
  end
end
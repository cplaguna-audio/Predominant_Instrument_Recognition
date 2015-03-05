% Extract a feature vector from an audio signal.
function features = extractACAFeatures(audio, Fs, mode)

features = [];

ACA_FEATURES = ...
    {'SpectralCentroid'; 'SpectralCrest'; 'SpectralDecrease'; ...
     'SpectralFlatness'; 'SpectralFlux'; 'SpectralKurtosis'; ...
     'SpectralMfccs'; 'SpectralPitchChroma'; 'SpectralRolloff'; ...
     'SpectralSkewness'; 'SpectralSlope'; 'SpectralSpread'; ...
     'SpectralTonalPowerRatio'; 'TimeAcfCoeff'; 'TimeMaxAcf'; ...
     'TimePeakEnvelope'; 'TimePredictivityRatio'; 'TimeRms'; ...
     'TimeStd'; 'TimeZeroCrossingRate'};

for(i=1:size(ACA_FEATURES, 1));
  current_features_time = ComputeFeature(ACA_FEATURES{i}, audio, Fs);
  num_current_features = size(current_features_time, 1);           

  for(i = 1:num_current_features)
    current_feature = mean(current_features_time(i,:));
    features = [features current_feature];
  end
end
   
end
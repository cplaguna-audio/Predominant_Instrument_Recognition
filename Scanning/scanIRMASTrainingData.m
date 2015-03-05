% Reads the IRMAS dataset into 
function [audio_filenames, labels, metadata] = ...
    scanIRMASTrainingData(root_path, QUICK_AND_DIRTY)
  
% Data for each instrument is stored in its own subdirectory. First, find
% the correct paths.
subdirs = dir(root_path);
subdirs(~[subdirs.isdir]) = [];
num_subdirs = size(subdirs,1);
to_remove = [];

% Remove . and .. from the subdirs list
for (label_idx=1:num_subdirs)
  dir_name = subdirs(label_idx).name;
  if (strcmp(dir_name, '.') || strcmp(dir_name, '..'))
    to_remove = [to_remove; label_idx];
  end
end
subdirs(to_remove) = [];
num_labels = size(subdirs,1);

audio_filenames = {};
labels = [];
metadata = [];

% Scan data for each instrument.
for (label_idx=1:num_labels)
  cur_label = label_idx - 1;
  cur_path = strcat(root_path, subdirs(label_idx).name);
  filenames = dir(strcat(cur_path, '/*.wav'));
  num_files = size(filenames,1);
  
  % Loop through files.
  for (file_idx=1:num_files)
    % To run quickly for testing.
    if (file_idx > 20 && QUICK_AND_DIRTY)
      break;
    end
    
    cur_filename = strcat(cur_path, '/', filenames(file_idx).name);
    cur_metadata = scanMetadata(cur_filename);
    
    audio_filenames = ...
        {audio_filenames{:} cur_filename};
    labels = [labels; cur_label];
    
    if(~isempty(cur_metadata))
      meatdata = [metadata; cur_metadata];
    end
  end
end

end
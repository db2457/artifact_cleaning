%% SETTINGS


DATA_DIRECTORY = cd;
CODE_DIRECTORY = cd;
filename = '206'; % filename of HDF5 file to be cleaned

%% 

cd(CODE_DIRECTORY)

% STEP 1: Load ABP and NIRS signals from HDF5 signal
[abp_raw,nirsl_raw,nirsr_raw] = getData(filename,DATA_DIRECTORY);
    
% STEP 2: Clean signals
[abp_cleaned,abp_features] = artifact_cleaner(abp_raw, 0); % clean blood pressure signal
[nirsl_cleaned,nirsl_features] = artifact_cleaner(nirsl_raw, 1); % clean left NIRS signal
[nirsr_cleaned,nirsr_features] = artifact_cleaner(nirsr_raw, 1); % clean right NIRS signal

% STEP 3: Overwrite cleaned data onto original HDF5 signal.
writeData(abp_cleaned,nirsl_cleaned,nirsr_cleaned,filename,DATA_DIRECTORY)






function [cleanedData,windowFeatures] = artifact_cleaner(rawData, isNIRS) 
% FUNCTION NAME: 
%   artifact_cleaner
%
% DESCRIPTION:
%   Cleans ICM+ NIRS and ABP signals by windowing data and calculating a 
%   line-length and NB-SQI score for each window, respectively. If a feature 
%   for a given window does not meet a pre-defined threshold for data quality,
%   then the signal contained within that window is removed (set ot NaN).
%   Other thresholds are based on phsyiologically acceptable criteria.

% INPUT (REQUIRED):
%   rawData - (single, Nx1) data from .HDF5 file with hfread() where N =
%   number of samples.
% 
%   isNIRS - (binary, 1x1) 1 if signal is NIRS. 0 if signal is ABP.
%   
% OUTPUT:
%   cleanedSignal - (double vector, Nx1) 
%   windowFeatures - (double vector, Wx1) calculated features for each
%   window, where W = number of windows contained in signal. 
%
% ASSUMPTIONS AND LIMITATIONS:
%   
%
% REVISION HISTORY:
%   

%% SETTINGS

NBSQI_THRESHOLD = 2.7;
LINELENGTH_THRESHOLD = 300;

LL_winLen = 60; LL_winDisp = 60; % LINE LENGTH WINDOW SPECIFICATIONS (seconds)
NBSQI_winLen = 3; NBSQI_winDisp = 3; % NB-SQI WINDOW SPECIFICATIONS (seconds)


%% CLEANING

if isNIRS % signal is NIRS 
    

    threshold = LINELENGTH_THRESHOLD;
    
    % Line-length filter
    sampleRate = 1;
    [cleanedData,windowFeatures] = window(double(rawData),sampleRate,LL_winLen,LL_winDisp,1,1,threshold); % CLEAN

    % Threshold filter 
    min = 50; % minimum acceptable NIRS value
    max = 100; %  maximum acceptable NIRS value
    bad_indices = (cleanedData < min) | (cleanedData > max); % get bad indices 
    cleanedData(bad_indices) = NaN; % replace bad indices with NaNs

    bad_indices = (cleanedData < min) | (cleanedData > max); % get bad indices 
    cleanedData(bad_indices) = NaN; % replace bad indices with NaNs
    
else % signal is ABP
    
    threshold = NBSQI_THRESHOLD;
     
    % NB-SQI filter
    sampleRate = 125;
    [cleanedData,windowFeatures] = window(double(rawData),sampleRate,NBSQI_winLen,NBSQI_winDisp,0,1,threshold); % CLEAN  

end
    


end
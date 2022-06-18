function [cleanedData,windowFeatures] = window(rawData,sampleRate,winLen, winDisp,isNIRS,cushion,threshold)

% INPUT (REQUIRED):
%   rawData - (double vector) Input signal
%   sampleRate - (double) Sampling rate (Hz)
%   winLen - (double) Window length (s)
%   winDisp - (double) Window displacement (s)
%   isNIRS - (binary) 1 if NIRS signal.
%   cush - (double) cleaning cushion (min)
%   threhsold - (double) cleaning threshold

% OUTPUT:
%   cleaned_data - (double vector) Cleaned data
%   windowFeatures - (double vector) Calculated features for each window
%


% Define anonymous functions
NumWins = @(xLen,sampleRate,winLen,winDisp) 1 + floor(((xLen/sampleRate) - winLen)/winDisp); 

% Calculate number of complete windows in this signal
num_windows = NumWins(length(rawData),sampleRate,winLen,winDisp); 

LLfn = @(x) sum(abs(diff(x)));
len = winLen * sampleRate; % convert to samples
disp = winDisp * sampleRate; % convert to samples        
cush = (cushion * 60) * sampleRate; % convert cush to samples


% Initialize output variables
cleanedData = rawData;
windowFeatures = zeros(1,num_windows);





%% CALCULATE FEATURE FOR i'TH WINDOW
for i = 1:num_windows % iterate through windows
    
    % get ith window
    if (i==1)
        start_index = 1;
        end_index = len;
    else 
        start_index = disp*(i-1);
        end_index = start_index + len;
    end
    

    window = rawData(start_index:end_index);
    nan_indices = isnan(window); % find which values are NaN
    zero_nan_window = window; % copy window over
    zero_nan_window(nan_indices) = 0; % set NaN values to zero
    

    if isNIRS
         feat_calc = LLfn(zero_nan_window); % calculate line length for that window
    else

        try
            
            feat_calc = mean(sqi_measure(zero_nan_window,125)); % calculate NB-SQI for that window
        catch
            
            feat_calc = 0;
            
        end
        
    end

    
    % Calculate feature for this window and check pre-defined thresholds
    if isNIRS
        decision = feat_calc > threshold || feat_calc < 0.1; % get rid of flat NIRS signals
    else
        decision = feat_calc < threshold;
    end



    % decision = 1 means window contains artifact
    if decision

        if end_index + cush > length(rawData) % check for out of right bounds

            S = start_index-cush;
            E = end_index;
            cleaned_data(S:E) = NaN;

        elseif start_index - cush <= 1 % check for out of left bounds

            S = start_index;
            E = end_index+cush;
            cleaned_data(S:E) = NaN;

        else

            S = start_index-cush;
            E = end_index+cush;
            cleaned_data(S:E) = NaN; % no out of bounds issue


        end


     

    end



    
    % calculate and append feature
    windowFeatures(i) = feat_calc;
    
    
    
end

end
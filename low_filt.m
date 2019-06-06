function data_filt = low_filt(fc,data)

%fc = 0.5; % Cut off frequency
fs = 50; % Sampling rate

[b,a] = butter(6,fc/(fs/2)); % Butterworth filter of order 6
data_filt = filtfilt(b,a,data); % Will be the filtered signal
end



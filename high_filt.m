function data_filt = high_filt(fc,data)

fs = 50; % Sampling rate

[b,a] = butter(6,fc/(fs/2),'high'); % Butterworth filter of order 6
data_filt = filtfilt(b,a,data); % Will be the filtered signal
end

function y = seedpixel(I,seedx,seedy,low,high)

%plot time series of seedpixel
y = squeeze(I(seedy,seedx,:)); 

%baseline (lowest 5%) 
tmp = sort(y); %sort timeseries from low to high values
mean_lows = mean(tmp(round(length(y)*0.05))); %find lowest 5% if values
y = double(y)-mean_lows; %subtract 5% lowest values = df
y = (y./mean_lows)*100; %df/f - divide by lowest values - multiply by 100 to give percentage change from baseline

%mean baseline
% mean_base = mean(y); % mean of timeseries
% y = double(y) - mean_base; %subtract mean from timeseries
% y = (y./mean_base)*100; %divide by mean - multiply by 100 ti give percentage change

gsr = mean(y); %find mean of time series
y = y - gsr; %subtract mean (account for illumination variation and fluctuation

y = detrend(y);

end
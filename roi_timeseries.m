function [X_dff] = roi_timeseries(roi,I)

idx = find(roi>0);
[r, c] = ind2sub(size(roi), idx);

x = zeros(size(I,3),length(r)); 
for i = 1:length(r)
    x(:,i) = I(r(i),c(i),:);
end
X = mean(x, 2);

tmp = sort(X); %sort timeseries from low to high values
mean_lows = mean(tmp(round(length(X)*0.05))); %find lowest 5% if values
mean_lows = mean(X);
X_dff = double(X)-mean_lows; %subtract 5% lowest values = df
X_dff = (X_dff./mean_lows)*100; %df/f - divide by lowest values - multiply by 100 to give percentage change from baseline

gsr = mean(X_dff); %find mean of time series
X_dff = X_dff - gsr; %subtract mean (account for illumination variation and fluctuation

%needed?
X_dff = detrend(X_dff);

end 
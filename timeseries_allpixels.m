
load('mean_lows');

idx = find(roi>0);
[r, c] = ind2sub(size(roi), idx);

x = zeros(size(I,3),length(r)); 
for i = 1:length(r)
    x(:,i) = I(r(i),c(i),:);
end


for i = 1:size(x,2)
tmp = sort(x(:,i)); %sort timeseries from low to high values
mean_lows = mean(tmp(round(length(x(:,i))*0.05))); %find lowest 5% if values
mean_lows = mean(x(:,i));
dff(:,i) = double(x(:,i))-mean_lows; %subtract 5% lowest values = df
dff(:,i) = (dff(:,i)./mean_lows)*100; %df/f - divide by lowest values - multiply by 100 to give percentage change from baseline

gsr = mean(dff(:,i)); %find mean of time series
dff(:,i) = dff(:,i) - gsr; %subtract mean (account for illumination variation and fluctuation

%needed?
dff(:,i) = detrend(dff(:,i));
end
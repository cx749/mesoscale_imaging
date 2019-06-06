function stim_activity(I,type)
% Find mean pixel intensity for ROI and create a timeseries of each stim

if type == 'still'
load('still ROI activation')
else
load('ROI activation')
end

idx = find(threshIdx>0);
[r, c] = ind2sub(size(threshIdx), idx);

x = zeros(size(I,3),length(r)); 
for i = 1:length(r)
    x(:,i) = I(r(i),c(i),:);
end
X = mean(x, 2);

B0 = linspace(500,10000,20); %end of each stim trial

%Split timeseries into individual stim trials
for i = 1:20;
r1 = (B0(1,i)-499);
r2 = (B0(1,i)-475);
r3 = (B0(1,i)-1);
B(1,i) = mean(X((r1):(r2),1)); %average baseline for each trial

f(1:499,i) = (((X((r1):(r3),1)) - B(1,i))/B(1,i))*100; %baseline corrected stim trial

end

for i = 1:20;
    r1 = (B0(1,i)-499);
    r2 = (B0(1,i)-475);
    r3 = (B0(1,i)-1);
    for j = 1:size(x,2)
pixel = x(:,j);
B(1,i) = mean(pixel((r1):(r2),1)); %average baseline for each pixel

traces(1:499,j) = (((pixel((r1):(r3),1)) - B(1,i))/B(1,i))*100; %baseline corrected pixel
    end
    max_f(1:499,i) = max(traces');
end

save('individual max response traces','max_f');
save ('individual respose traces','f');
save ('baselines', 'B');

%% extract timeseries from barrel ROI
X_dff = roi_timeseries(threshIdx,I); %left barrel ROI timeseries
 
save('barrel trace', 'X_dff'); %save barrel trace



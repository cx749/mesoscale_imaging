function output = time_series_basics()
load('seedpixel_timeseries');
load('movement-log.mat');

%% time spend not moving  
    
still = size(time_series,2)-sum(movement_log);

%% whole brain freqency
 load('whole brain trace');
[Wpks,Wlocs] = find_spon_peaks(W_dff,movement_log);
output(1,3) = (size(Wpks,1)./(still./3000));

exist 'left hem trace';

if ans > 0
%R and left hem
load('left hem trace')
load('right hem trace')

[LHpks,LHlocs] = find_spon_peaks(LH_dff,movement_log);
output(1,4) = (size(LHpks,1)./(still./3000));

[RHpks,RHlocs] = find_spon_peaks(RH_dff,movement_log);
output(1,5) = (size(RHpks,1)./(still./3000));
 
output(1,6) = corr(LH_dff,RH_dff);
else 
end

%seedpixel timeseries analsysis
for i = 1:size(time_series,1);
    
j = 6; %gap at start of output file

%find peaks in timeseries trace
[pks, locs]  = find_spon_peaks(time_series(i,:)',movement_log); %find all peaks over 1% df/f during still periods

% frequency
output(1,i+j) = (size(pks,1)./(still./3000));
j = j+size(time_series,1);

%normalised freqency
A = size(pks,1)./size(Wpks,1);
output(1,i+j) = A./(still./3000);
j = j+size(time_series,1);

% rise and fall times
if size(locs,1) > 1
[max_dvdt,min_dvdt] = spon_rise_times(time_series(i,:),pks,locs); 
output(1,i+j) = max_dvdt; 
j = j+size(time_series,1);
output(1,i+j) = min_dvdt;
j = j+size(time_series,1);
else
if size(locs,1) == 1 && locs > 50
[max_dvdt,min_dvdt] = spon_rise_times(time_series(i,:),pks,locs); 
output(1,i+j) = max_dvdt; 
j = j+size(time_series,1);
output(1,i+j) = min_dvdt;
j = j+size(time_series,1);
else 
output(1,i+j) = NaN;
j = j+size(time_series,1);
output(1,i+j) = NaN;
j = j+size(time_series,1);
end
end

%extract waveforms and get mean height
if size(locs,1) > 1
f = wave_form_extraction(time_series(i,:),locs);
B0 = mean(f(1:10,:));
M = max(f(20:80,:));
heights = M-B0;
output(1,i+j) = mean(heights);
j = j+size(time_series,1);
else
    if size(locs,1) == 1 && locs > 50
    f = wave_form_extraction(time_series(i,:),locs);
    B0 = mean(f(1:10,:));
M = max(f(20:80,:));
heights = M-B0;
output(1,i+j) = mean(heights);
j = j+size(time_series,1);
else 
output(1,i+j) = NaN;
j = j+size(time_series,1);
end
end

output(1,i+j) = size(pks,1);

end

end


% import database as string array

%change name to data_base 

data_base = whiskertrimmedrecordings; %developmentalrecordings; %***change name of imported file here***
%%
ind=find(ismember(data_base(:,3),'spon')); %find location of files in file record matrix

%
for f = 57:(size(ind,1)+1)
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(f-1,1)),2))); %go to current file directory

% if (data_base(ind(f-1,1),5)) == 'y' %if own-ROI column is yes load ROIs in this folder
% else
cd ../ %otherwise to to main folder to load ROIs
% end

%load seedpixel locations
load('seedpixel-locations');
load('whole brain ROI');

% go to recording file
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(f-1,1)),2))); %go to current file directory

% load TIFFs and concatinate into 
I = database_file_load(f,data_base,ind);

% draw whole brain ROI on image to check ROIs match recoding
roi_disp = sum(I,3);
figure; imagesc(roi_disp);axis tight; axis equal; colormap(gray)
hold on
scatter(seedpixels(:,1),seedpixels(:,2), 'x', 'k');
title(ind((f-1),:));

%extract timeseries (baseline correct lowest 5% df/f% and detrend) 
time_series = zeros(size(seedpixels,1),size(I,3));

%somatosensory regions
time_series(1,:) = seedpixel(I,seedpixels(1,1),seedpixels(1,2)); %L barrel seedpixel timeseries 
time_series(2,:) = seedpixel(I,seedpixels(10,1),seedpixels(10,2)); %R barrel seedpixel timeseries 
time_series(3,:) = seedpixel(I,seedpixels(7,1),seedpixels(7,2)); %L forepaw seedpixel timeseries 
time_series(4,:) = seedpixel(I,seedpixels(16,1),seedpixels(16,2)); %R forepaw seedpixel timeseries 
time_series(5,:) = seedpixel(I,seedpixels(6,1),seedpixels(6,2)); %L hindpaw seedpixel timeseries 
time_series(6,:) = seedpixel(I,seedpixels(15,1),seedpixels(15,2)); %R hindpaw seedpixel timeseries 

%motor regions
time_series(7,:) = seedpixel(I,seedpixels(8,1),seedpixels(8,2)); %L M1 seedpixel timeseries 
time_series(8,:) = seedpixel(I,seedpixels(17,1),seedpixels(17,2)); %R M1 seedpixel timeseries 
time_series(9,:) = seedpixel(I,seedpixels(9,1),seedpixels(9,2)); %L M2 seedpixel timeseries 
time_series(10,:) = seedpixel(I,seedpixels(18,1),seedpixels(18,2)); %R M2 seedpixel timeseries 

%parietal cortex
time_series(11,:) = seedpixel(I,seedpixels(3,1),seedpixels(3,2)); %L visual seedpixel timeseries 
time_series(12,:) = seedpixel(I,seedpixels(12,1),seedpixels(12,2)); %R visual seedpixel timeseries 
time_series(13,:) = seedpixel(I,seedpixels(4,1),seedpixels(4,2)); %L retrosplenial seedpixel timeseries 
time_series(14,:) = seedpixel(I,seedpixels(13,1),seedpixels(13,2)); %R retrosplenial seedpixel timeseries 
time_series(15,:) = seedpixel(I,seedpixels(5,1),seedpixels(5,2)); %L PPC seedpixel timeseries 
time_series(16,:) = seedpixel(I,seedpixels(14,1),seedpixels(14,2)); %R PPC seedpixel timeseries 

%auditory cortex
time_series(17,:) = seedpixel(I,seedpixels(2,1),seedpixels(2,2)); %L auditory seedpixel timeseries 
time_series(18,:) = seedpixel(I,seedpixels(11,1),seedpixels(11,2)); %R auditory seedpixel timeseries 

save('seedpixel_timeseries', 'time_series'); %save timeseries matrix

%% frequecy band to filter at
low = 1; %low pass filter freqency cut off
high = 0.1; %high pass filter frequency cut off

% frequency filter time_series
time_series_filt = zeros(size(seedpixels,1),size(I,3));
for i = 1:size(time_series,1)
time_series_filt(i,:) = low_filt(low,time_series(i,:));
time_series_filt(i,:) = high_filt(high,time_series_filt(i,:));
end

%create correlation matrix
corr_matrix = zeros(18,18);

for i = 1:18
    for j = 1:18
    coef = corrcoef(time_series_filt(i,:),time_series_filt(j,:));
    corr_matrix(i,j) = coef(1,2);
    end
end

%plot and save
clims = [0 1];
figure;imagesc(corr_matrix,clims);colormap(jet);colorbar;

save('corr_matrix', 'corr_matrix')
saveas(gcf,'corr_matrix.png');
close
%% correlation with movement
load('movement-envelope'); %load movement envelope
ks = ks(:,1:size(time_series_filt,2));%make movement trace only as long as timeseries 
%create correlation matrix between time-series and movement
for i = 1:18
   coef = corrcoef(time_series_filt(i,:),ks);
    corr_movement(i,1) = coef(1,2);
end

%plot and save
figure;imagesc(corr_movement);colormap(jet);colorbar;
save('corr_movement', 'corr_movement')
saveas(gcf,'corr_movement.png');
close
%% seedpixel correlation maps
%seedpixel_maps(I, BW, seedpixels,time_series_filt,low,high);
end
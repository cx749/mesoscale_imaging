% function [moving_in] = (dff, locs)

pre = -20; %how many frame before the event peak to track
post = 20; %how many frame after the event peak to track

span = -pre+post;

load('mean_lows');
load('barrel ROI');
load('L hemisphere ROI');
load('movement-log');
load('barrel trace');

outline = cell2mat(bwboundaries(threshIdx));%create outline of barrel ROI

%X = low_filt(7,X_dff); %filter trace with a lowpass filter

[pks,locs]  = find_spon_peaks(7,X_dff,movement_log,0); %detect events during still periods - NB 1 at end means graph of locations produced

%% get surround timeseries 

% s_dff = roi_timeseries(roi,I);
% 
% corr(s_dff,X_dff);

%%
for i = 1:size(locs,1) %for all events detected
    if locs(i,:) > 21 && locs(i,:) < (size(X,1)-20) %if far enough from start or end of trace
        
        peak = (((double(I(:,:,(locs(i,:)))) - mean_lows)./mean_lows)*100.*L); %baseline correct image for frame of event peak

        peak_ROI = peak.*threshIdx;

        [pkResp, pkIdx] = max2(peak_ROI);  %peak response pixel in ROI for event peak frame

%plot image of heatmap for event peak, with location of max pixel and the & barrel ROI boundary
figure;imagesc(peak);hold on;scatter(pkIdx(:,2),pkIdx(:,1),'k');plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);set(gca,'XTick',[], 'YTick', []);
    end
end

%%
f = 1; 
clear event_series
for k = pre:post %find a baseline correct image for each frame for the period before and after the event
   
    %peak = (((double(I(:,:,(locs(i,:)+(k)))) - mean_lows)./mean_lows)*100.*L); 
    peak = (((double(I(:,:,(locs(i,:)+(k)))))));
 peak_ROI = peak.*threshIdx;
[pkResp, pkIdx] = max2(peak_ROI);  %peak response pixel

event_series(:,:,f) = peak; %create stack of frames

figure;imagesc(peak);hold on;scatter(pkIdx(:,2),pkIdx(:,1),'k');plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);set(gca,'XTick',[], 'YTick', []);

f = f+1;
% location(k+21,:) = pkIdx;
% amp(k+21,:) = pkResp;

end

%% save example event tiff stack  
event_series = single(event_series);
saveastiff(event_series, 'example_match.tif');



%%
for j = size(location,1)

  if threshIdx(location(j,2),location(j,1)) == 1
      out_roi (j,1) = 1;
  else
        out_roi (j,1) = 0;
  end
    
end

if sum(out_roi(1:0+(-pre),:)) > 0 
    moving_in(i,:) = 1;
else 
    moving_in(i,:) = 0;
end

if sum(out_roi(2+(-pre):end,:)) > 0 
    moving_out(i,:) = 1;
else 
    moving_out(i,:) = 0;
end
peak_ave = mean(I(:,:,(locs(i,:)+(pre)):(locs(i,:)+(post))),3);
peak_ave = ((peak_ave - mean_lows)./mean_lows)*100;

figure;imagesc(peak_ave);hold on;scatter(location(:,2),location(:,1),'k');
   

    else 
        moving_in(i,:) = NaN;
        moving_out(i,:) = NaN;
    end
    
end

% visualise

travel = zeros(270,480);
figure; imagesc(travel); hold on;scatter(location(:,1),location(:,2))

peak_ave = mean(I(:,:,(locs(i,:)+(pre)):(locs(i,:)+(post))),3);
peak_ave = ((peak_ave - mean_lows)./mean_lows)*100;

figure;imagesc(peak_ave);hold on;scatter(location(:,2),location(:,1),'k');

%% examples of events
numb = 1;
pre = -30;
post = 30;

event_number = size(locs,1);
sample = randi([1 event_number],1,numb);
 
outline = cell2mat(bwboundaries(threshIdx));%create outline of barrel ROI


for n = 1:numb
    s = sample(1,n);
    figure
for k = pre:post
     peak = (((double(I(:,:,(locs(s,:)+(k)))) - mean_lows)./mean_lows)*100.*L); 
     %subplot(post/2,post/2,k+11);
     figure;imagesc(peak);hold on;plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);set(gca,'XTick',[], 'YTick', []);
end
end




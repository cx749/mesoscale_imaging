% function [moving_in] = (dff, locs)

pre = -20;
post = 20;

X = low_filt(7,dff); %filter trace with 1hz lowpass filter

load('mean_lows');
load('barrel ROI');
load('L hemisphere ROI');

for i = 1:size(locs,1)
    if locs(i,:) > 21 && locs(i,:) < (size(X,1)-20)
for k = pre:post
    peak = (((double(I(:,:,(locs(i,:)+(k)))) - mean_lows)./mean_lows)*100.*L); 

[pkResp, pkIdx] = max2(peak);  %peak response pixel

location(k+21,:) = pkIdx;
amp(k+21,:) = pkResp;

end

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

% travel = zeros(270,480);
% figure; imagesc(travel); hold on;scatter(location(:,1),location(:,2))

% peak_ave = mean(I(:,:,(locs(i,:)+(pre)):(locs(i,:)+(post))),3);
% peak_ave = ((peak_ave - mean_lows)./mean_lows)*100;
% 
% figure;imagesc(peak_ave);hold on;scatter(location(:,2),location(:,1),'k');


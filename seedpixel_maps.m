function seedpixel_maps(I, BW, seedpixels,time_series,low,high)

%% spatial smoothing ??
%I = imgaussfilt(I,4); %spacial smoothing - gaussian filter, sigma radius 4

%%
for k = 1:size(time_series,1)
   
y = time_series(k,:)'; %time_series for seedpixel

xcmap = zeros(size(I,1),size(I,2)); %pre allocate xcorr map matrix

%%cross correlated centre barrel pixel with all other pixels in image
for i = 1:size(I,1); %move through all pixels in x
for j = 1:size(I,2); %move through all pixels in y
     clear xcorr
     if BW(i,j) == 1
     x = squeeze(I(i,j,:));  %time series of current pixel %can adjust time period taken
     tmp = sort(x); %sort timeseries from low to high values
     mean_lows = mean(tmp(round(length(x)*0.05))); %find lowest 5% if values
     x = double(x)-mean_lows; %subtract 5% lowest values = df
     x = (x./mean_lows)*100; %df/f
     x = low_filt(low,x);
     x = high_filt(high,x);
    
  
     xcmap (i,j) = corr(x,y);
     else
    end
end
end

clims = [0 1];
figure 
imagesc(xcmap, clims)
colorbar;
colormap(jet);
hold on

%% saving
if k == 1
    scatter(seedpixels(1,1),seedpixels(1,2), 'x','k');
    saveas(gcf,'Lbarrel corr-map.png')
    save('Lbarrel corr-map','xcmap')
     elseif k == 2
     scatter(seedpixels(10,1),seedpixels(10,2), 'x','k');
     saveas(gcf,'Rbarrel corr-map.png')
     save('Rbarrel corr-map','xcmap')
     elseif k == 3
     scatter(seedpixels(7,1),seedpixels(7,2), 'x','k');
     saveas(gcf,'Lforepaw corr-map.png')
     save('Lforepaw corr-map','xcmap')
     elseif k == 4
     scatter(seedpixels(16,1),seedpixels(16,2), 'x','k');
     saveas(gcf,'Rforepaw corr-map.png')
     save('Rforepaw corr-map','xcmap')
     elseif k == 5
     scatter(seedpixels(6,1),seedpixels(6,2), 'x','k');
     saveas(gcf,'Lhindpaw corr-map.png')
     save('Lhindpaw corr-map','xcmap')
     elseif k == 6 
     scatter(seedpixels(15,1),seedpixels(15,2), 'x','k');
     saveas(gcf,'Rhindpaw corr-map.png')
     save('Rhindpaw corr-map','xcmap')
     elseif k == 7
     scatter(seedpixels(8,1),seedpixels(8,2), 'x','k');
     saveas(gcf,'LM1 corr-map.png')
     save('LM1 corr-map','xcmap')
     elseif k == 8
     scatter(seedpixels(17,1),seedpixels(17,2), 'x','k');
     saveas(gcf,'RM1 corr-map.png')
     save('RM1 corr-map','xcmap')
     elseif k == 9
     scatter(seedpixels(9,1),seedpixels(9,2), 'x','k');
     saveas(gcf,'LM2 corr-map.png')
     save('LM2 corr-map','xcmap')
     elseif k == 10
     scatter(seedpixels(18,1),seedpixels(18,2), 'x','k');
     saveas(gcf,'RM1 corr-map.png')
     save('RM1 corr-map','xcmap')
     elseif k == 11
     scatter(seedpixels(3,1),seedpixels(3,2), 'x','k');
     saveas(gcf,'Lvisual corr-map.png')
     save('Lvisual corr-map','xcmap')
     elseif k == 12
     scatter(seedpixels(12,1),seedpixels(12,2), 'x','k');
     saveas(gcf,'Rvisual corr-map.png')
     save('Rvisual corr-map','xcmap')
     elseif k == 13
     scatter(seedpixels(4,1),seedpixels(4,2), 'x','k');
     saveas(gcf,'LRS corr-map.png')
     save('LRS corr-map','xcmap')
     elseif k == 14
     scatter(seedpixels(13,1),seedpixels(13,2), 'x','k');
     saveas(gcf,'RRS corr-map.png')
     save('RRS corr-map','xcmap')
     elseif k == 15
     scatter(seedpixels(5,1),seedpixels(5,2), 'x','k');
     saveas(gcf,'LPPC corr-map.png')
     save('LPPC corr-map','xcmap')
     elseif k == 16
     scatter(seedpixels(14,1),seedpixels(14,2), 'x','k');
     saveas(gcf,'RPPC corr-map.png')
     save('RPPC corr-map','xcmap')
      elseif k == 17
     scatter(seedpixels(2,1),seedpixels(2,2), 'x','k');
     saveas(gcf,'Lauditory corr-map.png')
     save('Lauditory corr-map','xcmap')
     elseif k == 18
     scatter(seedpixels(11,1),seedpixels(11,2), 'x','k');
     saveas(gcf,'Rauditory corr-map.png')
     save('Rauditory corr-map','xcmap')
     
   
end
 close
end


end
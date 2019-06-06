function [] = stim_heatmap(I,BW)
%Modified from WFCI.m by Jon Witton, 7th Feb 2015

%%Define parameters
Fs = 50;  %sampling frequency 
trial_num = 20; %number of trials
trial_length = 10; %length of trials (in sec)
baseDur = 0.5; %1; %duration of pre-stimulation onset baseline period (in sec)
total_length = trial_num*trial_length;

respLag = 0; %duration of lag post-stimulation onset to measurement of response (in sec)
respDur = 1; %duration of response measurement epoch (in sec)



stim = linspace(baseDur, (total_length-(trial_length-baseDur)), trial_num);  %steps that stim go in: (first stim star, last stim start, number of stims)

%%generate heatmap

cMap = zeros(size(I, 1), size(I, 2));  %pre-allocate cortical map array
for i = 1:size(I, 1)  %move through row (Y-dimension) pixels
    
    for j = 1:size(I, 2)  %move through column (X-dimension) pixels
        
        clear x   %clear x from previous loop
        x(:,1) = double(I(i, j, :));  %pixel intensity time series 
                      
        % Cycle through all trials
        dFF = zeros(length(stim), 1);  %pre-allocate deltaF/F response amplitude array for each trial 
        for k = 1:length(stim)
    
            % Baseline (F0)
            bFirst = floor((stim(k)-baseDur)*Fs)+1;  %first basline sample of trial
            bLast = floor(stim(k)*Fs);  %last baseline sample of trial
            base = x(bFirst:bLast);  %baseline epoch of trial
            F0(1,k) = mean(base);  %baseline average of trial

            % Response
            rFirst = floor((stim(k)+respLag)*Fs)+1;  %first basline sample of trial
            rLast = floor((stim(k)+(respLag+respDur))*Fs)+1;  %last baseline sample of trial
            response = x(rFirst:rLast);  %response epoch of trial
            F = mean(response);  %response average of trial

            %deltaF/F response amplitude for trial
            dFF(k) = (F - F0(1,k))/F0(1,k); 
        end
        
        
        % Cortical map value for current pixel
        cMap(i,j) = mean(dFF)*100; %average of deltaF/F response amplitudes across all trials (in percent)  
    end
end


cMapF_all = imfilter(cMap, fspecial('gaussian', [9 9], 2), 'symmetric');  %smooth cortical map with Gaussian filter to remove noise
cMapF = cMapF_all.*BW; %extract brain ROI
save ('average 1sec activation map','cMapF');


%%Plot cortical heatmap and save
figure, imagesc(cMapF)  
cbar = colorbar;
ylabel(cbar,'% \DeltaF/F_0', 'fontname', 'arial')
set(gca,'clim',[0 max(max(cMapF))]);

saveas(gcf,'Average 1sec heatmap.tif');
close

%%Plot cortical map overalyed on vasculature
figure,
% Layer 1: Plot scaled cortical map - for colorbar
imshow(cMapF, [])
colormap(jet)
cbar2 = colorbar;
ylabel(cbar2,'% \DeltaF/F', 'fontname', 'arial')

hold on

% Layer 2: Plot cortical vasculature in grayscale
Iref = imsharpen(mean(I(:, :, 1:10), 3));  %create cortical vasculature reference image using average of first 10 images of input stack
Irefu16 = uint16(Iref);  %convert averaged reference image into 16bit grayscale
Irefrgb = label2rgb(Irefu16, 'gray');  %convert 16bit grayscale reference image to an RBB image in grayscale
imshow(Irefrgb);  %plot the grayscale RBG reference image on top of first cortical map

% Layer 3: Plot cortical map with jet colormap
cMapFn1 = cMapF - min(min(cMapF));  %normalise the cortical map floor to 0 by subtracting the minimum
cMapFn2 = cMapFn1 / max(max(cMapFn1));  %normalise the cortical map ceiling to 1 by dividing by the maximum
cMapFu16 = uint16(cMapFn2 * 2^16);  %convert the normalised cortical map to a scaled 16bit grayscale image 
cMapFrgb = label2rgb(cMapFu16, 'jet');  %convert the 16bit cortical map to an RGB image with the 'jet' colormap 
h3 = imshow(cMapFrgb);  %plot the RBG cortical map on top of the cortical vasculature reference image
set(h3, 'AlphaData', 0.35)  %adjust the transparency of the RBG cortical map to 35% opacity

saveas(gcf,'Average 1sec heatmap overlay.tif');
close


function stim_create_roi(type)
% Modified from WFCI_responseArea.m by J. Witton, 3 Feb 2015

if type == 'still'
    load('average 1sec still map');
    cMapF = sMapF;
else
    load('average 1sec activation map');
end

%Subtract mean of entire cortical map to control for (1) slow, oscillatory flcutuations in fluorescence 
%  (see Drew and Feldman, 2009, Cereb Cortex); (2) differences in GCaMP6expression between animals and across sessions within animals.
map = cMapF - mean(cMapF(:));

% Create threshold and find pixels which exceed it
[pkResp, pkIdx] = max2(map);  %peak response pixel

threshIdx = map > pkResp*0.5; %logical array of supra-threshold pixels - percentage of peak response 

%pick main region ROI
[regions, R] = bwboundaries(threshIdx);
if numel(regions) > 1
    regionArea = zeros(numel(regions), 1);
    for i = 1:numel(regions)
        regionMask = zeros(size(R));
        regionMask(R == i) = 1;
        regionArea(i) = numel(find(regionMask == 1));
    end
    [~, mainRegionIdx] = max(regionArea);
    mainRegion = zeros(size(R));
    mainRegion(R == mainRegionIdx) = 1;
 
    threshIdx = logical(mainRegion);
end


%% Plot the cortical map and suprathreshold field
scrsz  = get(0,'ScreenSize'); % get dimensions of the screen
f1 = figure('OuterPosition', [scrsz(3)/20 scrsz(4)*0.1 scrsz(3)/4 scrsz(4)*.85]);  %make the figure

% Cortical map
subplot(2,1,1);
imagesc(cMapF)
colormap('jet')
set(gca, 'xtick', [], 'ytick', [], 'clim', [0 pkResp])
colormap('jet')
freezeColors;

if  type == 'still'
title('still')
else
title('all')
end


% Suprathreshold pixels
subplot(2,1,2);
imagesc(threshIdx)
set(gca, 'xtick', [], 'ytick', [])
colormap(gray)


if  type == 'still'
save ('still ROI activation','threshIdx') %save ROI 
else
save ('ROI activation','threshIdx') %save ROI 
end

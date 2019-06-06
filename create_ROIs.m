function ROI = create_ROIs(I,threshIdx)
%% create ROIs
figure; set(gcf, 'Position', [800, 0, 1000, 600]) %position and size to 24" monitor

roi_disp = sum(I,3);
imagesc(roi_disp);axis tight; axis equal; colormap(gray) %image of FOV 
title('draw ROI')
%saveas(gcf,'surface.png'); %save image of FOV as png file

exist threshIdx;
if ans == 1
outline = cell2mat(bwboundaries(threshIdx)); %create outline of barrel ROI
hold on
plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1); %plot barrel ROI outline
else
end

%manually draw

ROI = roipoly; %create whole brain ROI


%close %close surface image


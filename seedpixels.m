figure; set(gcf, 'Position', [800, 0, 1000, 600]) %position and size to 24" monitor
roi_disp = sum(I,3);
imagesc(roi_disp);axis tight; axis equal; colormap(gray) %image of FOV 
title('draw ROI')
exist threshIdx;
if ans == 1
outline = cell2mat(bwboundaries(threshIdx)); %create outline of barrel ROI
outline2 = cell2mat(bwboundaries(bil_barrel)); %create outline of barrel ROI
hold on
plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1); %plot barrel ROI outline
plot(outline2(:, 2), outline2(:, 1), 'w', 'linewidth', 1); %plot barrel ROI outline
else
end

[lbx,lby] = getpts;
[rbx,rby] = getpts;
[lvx,lvy] = getpts;
[rvx,rvy] = getpts;
[lsx,lsy] = getpts;
[rsx,rsy] = getpts;
[lmx,lmy] = getpts;
[rmx,rmy] = getpts;



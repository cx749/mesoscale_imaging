%% *****load file location csv file as string array *****

% **** change name to data base
data_base = whiskertrimmedrecordings;%developmentalrecordings; %%
%%
ind=find(ismember(data_base(:,3),'whisk sing')); %find location of files in file record matrix

for i = 54:(size(ind,1)+1)
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

% if (data_base(ind(i-1,1),5)) == 'y' %if own-trace column is y load ROIs in this folder
% else
cd ../ %otherwise to to main folder to load ROIs
% end

%load ROIs
load ('whole brain ROI');
load ('barrel ROI');
load('R barrel ROI.mat')
load('RSL ROI.mat')
load('RSR ROI.mat')
load('VL ROI.mat')
load('VR ROI.mat')


% go to recording file
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory


% load TIFFs and concatinate into 
I = database_file_load(i,data_base,ind);


% draw whole brain ROI on image to check ROIs match recoding
roi_disp = sum(I,3);
figure;
imagesc(roi_disp);axis tight; axis equal; colormap(gray)
outline = cell2mat(bwboundaries(BW)); %create outline of whole brain ROI
outline2 = cell2mat(bwboundaries(threshIdx));
hold on
plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);
plot(outline2(:, 2), outline2(:, 1), 'w', 'linewidth', 1);
title(ind((i-1),:));
saveas(gcf,'ROI check.png');

% extract ROI timeseries
[X_dff] = roi_timeseries(threshIdx,I);
save ('barrel ROI trace', 'X_dff');
[R_dff] = roi_timeseries(bil_barrel,I);
save ('right barrel trace', 'R_dff');
[VL_dff] = roi_timeseries(VL,I);
save ('VL trace', 'VL_dff');
[VR_dff] = roi_timeseries(VR,I);
save ('VR trace', 'VR_dff');
[RSL_dff] = roi_timeseries(RSL,I);
save ('RSL trace', 'RSL_dff');
[RSR_dff] = roi_timeseries(RSR,I);
save ('RSR trace', 'RSR_dff');
[W_dff] = roi_timeseries(BW,I);
save ('whole brain trace', 'W_dff');


end
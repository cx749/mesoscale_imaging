%% creates ROIs for major sensory and association regions 
%% manually draw ROIs
load('FOV.mat'); %load top image of average FOV

I = frame;
bil_barrel = create_ROIs(I,threshIdx);
VL = roipoly;
VR = roipoly;
RSL = roipoly;
RSR = roipoly;


%% save ROIs
save ('barrel ROI', 'threshIdx');
save('R barrel ROI','bil_barrel')
save('RSL ROI','RSL')
save('RSR ROI','RSR')
save('VL ROI','VL')
save('VR ROI','VR')
%% create ROIs
bil_barrel = create_ROIs(I,threshIdx);
VL = roipoly;
VR = roipoly;
RSL = roipoly;
RSR = roipoly;
BW = roipoly;
L = roipoly;
R = roipoly;
background = roipoly;

save('barrel ROI', 'threshIdx')
save('right barrel ROI','bil_barrel')
save('VL ROI', 'VL')
save('VR ROI', 'VR')
save('RSL ROI', 'RSL')
save('RSR ROI', 'RSR')
save('whole brain ROI', 'BW')
save('L hemisphere ROI', 'L')
save('R hemisphere ROI', 'R')
save('background ROI', 'background')
%% extract timeseries from ROIs
X_dff = roi_timeseries(threshIdx,I); %left barrel ROI timeseries
R_dff = roi_timeseries(bil_barrel,I);  %right barrel ROI timeseries
VL_dff = roi_timeseries(VL,I); 
VR_dff = roi_timeseries(VR,I); 
RSL_dff = roi_timeseries(RSL,I); 
RSR_dff = roi_timeseries(RSR,I); 
W_dff = roi_timeseries(BW,I);
LH_dff = roi_timeseries(L,I);
RH_dff = roi_timeseries(R,I);
B_dff = roi_timeseries(background,I); %whole brain ROI timeseries


%save all timeseries
save('barrel ROI trace','X_dff');
save('right barrel trace','R_dff');
save('VL trace','VL_dff');
save('VR trace','VR_dff');
save ('RSL trace','RSL_dff');
save ('RSR trace','RSR_dff');
save('whole brain trace','W_dff');
save('L hem trace', 'LH_dff')
save('background trace','B_dff');
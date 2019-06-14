function [output] = spon_basics()
load('barrel trace.mat')
load('right barrel trace.mat')
load('VL trace.mat')
load('VR trace.mat')
load('RSL trace.mat')
load('RSR trace.mat')
load('whole brain trace')
load('movement-log.mat')


%% time spend not moving  
    
still = size(X_dff,1)-sum(movement_log);
%% find peaks (size and location) during still periods of recording
[Xpks, Xlocs]  = find_spon_peaks(1,X_dff,movement_log); %in L barrel ROI
[Rpks, Rlocs]  = find_spon_peaks(1,R_dff,movement_log); %in R barrel ROI
[VLpks, VLlocs]  = find_spon_peaks(1,VL_dff,movement_log); %in L visual ROI
[VRpks, VRlocs]  = find_spon_peaks(1,VR_dff,movement_log); %in R visual ROI
[RSLpks, RSLlocs]  = find_spon_peaks(1,RSL_dff,movement_log); %in L restrosplenial ROI
[RSRpks, RSRlocs]  = find_spon_peaks(1,RSR_dff,movement_log); %in R restrosplenia ROI
[Wpks, Wlocs]  = find_spon_peaks(1,W_dff,movement_log); %in whole brain ROI
% adjust orientation of traces
X_dff = X_dff';
R_dff = R_dff';
VL_dff = VL_dff';
VR_dff = VR_dff';
RSL_dff = RSL_dff';
RSR_dff = RSR_dff';
W_dff = W_dff';
%% find max and min dvdt of waveforms
[Xmax_dvdt,Xmin_dvdt] = spon_rise_times(1,X_dff,Xpks,Xlocs); %L barrel ROI
[Rmax_dvdt,Rmin_dvdt] = spon_rise_times(1,R_dff,Rpks,Rlocs); %R barrel ROI
[VLmax_dvdt,VLmin_dvdt] = spon_rise_times(1,VL_dff,VLpks,VLlocs); %L visual ROI
[VRmax_dvdt,VRmin_dvdt] = spon_rise_times(1,VR_dff,VRpks,VRlocs); %R visual ROI
[RSLmax_dvdt,RSLmin_dvdt] = spon_rise_times(1,RSL_dff,RSLpks,RSLlocs); %R rs ROI
[RSRmax_dvdt,RSRmin_dvdt] = spon_rise_times(1,RSR_dff,RSRpks,RSRlocs); %R rs ROI


% adjust orientation of traces
X_dff = X_dff';
R_dff = R_dff';
VL_dff = VL_dff';
VR_dff = VR_dff';
RSL_dff = RSL_dff';
RSR_dff = RSR_dff';
W_dff = W_dff';
%% create output file

j = 3;
output(1,j) = size(X_dff,1);j=j+1; %total recording length in frames
output(1,j) = still;j=j+1; %frames spend not moving

%barrel ROIs
output(1,j) = (size(Xpks,1)./(still./3000));j=j+1; %pks/min in L barrel ROI
output(1,j) = (size(Rpks,1)./(still./3000));j=j+1; %pks/min in R barrel ROI
output(1,j) = Xmax_dvdt;j=j+1; %average max_dvdt of L barrel waveforms
output(1,j) = Xmin_dvdt;j=j+1;%average min_dvdt of L barrel waveforms
output(1,j) = Rmax_dvdt;j=j+1; %average max_dvdt of R barrel waveforms
output(1,j) = Rmin_dvdt;j=j+1; %average min_dvdt of R barrel waveforms
output(1,j) = corr(X_dff,R_dff);j=j+1;%correlation between L and R barrel
if size(Xpks,1) > size(Rpks,1)
output(1,j) = (matched_peaks(5,Xpks,Xlocs,Rpks,Rlocs)/(size(Xpks,1))*100);j=j+1; % % of L and R barrel peaks within 200ms of each other
else
output(1,j) = (matched_peaks(5,Xpks,Xlocs,Rpks,Rlocs)/(size(Rpks,1))*100);j=j+1;
end
%visual ROIs
output(1,j) = (size(VLpks,1)./(still./3000));j=j+1; %pks/min in L visual ROI
output(1,j) = (size(VRpks,1)./(still./3000));j=j+1; %pks/min in R visual ROI
output(1,j) = VLmax_dvdt;j=j+1; %average max_dvdt of L visual waveforms
output(1,j) = VLmin_dvdt;j=j+1; %average min_dvdt of L visual waveforms
output(1,j) = VRmax_dvdt;j=j+1; %average max_dvdt of R visual waveforms
output(1,j) = VRmin_dvdt;j=j+1; %average min_dvdt of R visual waveforms
output(1,j) = corr(VL_dff,VR_dff);j=j+1;%correlation between L and R visual
if size(VLpks,1) > size(VRpks,1)
output(1,j) = (matched_peaks(5,VLpks,VLlocs,VRpks,VRlocs)/(size(VLpks,1))*100);j=j+1; % % of L and R visual peaks within 200ms of each other
else
output(1,j) = (matched_peaks(5,VLpks,VLlocs,VRpks,VRlocs)/(size(VRpks,1))*100);j=j+1;
end

%RS ROIs
output(1,j) = (size(RSLpks,1)./(still./3000));j=j+1; %pks/min in L RS ROI
output(1,j) = (size(RSRpks,1)./(still./3000));j=j+1; %pks/min in R RS ROI
output(1,j) = RSLmax_dvdt;j=j+1; %average max_dvdt of L RS waveforms
output(1,j) = RSLmin_dvdt;j=j+1; %average min_dvdt of L RS waveforms
output(1,j) = RSRmax_dvdt;j=j+1; %average max_dvdt of R RS waveforms
output(1,j) = RSRmin_dvdt;j=j+1; %average min_dvdt of R RS waveforms
output(1,j) = corr(RSL_dff,RSR_dff);j=j+1;%correlation between L and R RS
if size(RSLpks,1) > size(RSRpks,1)
output(1,j) = (matched_peaks(5,RSLpks,RSLlocs,RSRpks,RSRlocs)/(size(RSLpks,1))*100);j=j+1; % % of L and R visual peaks within 200ms of each other
else
output(1,j) = (matched_peaks(5,RSLpks,RSLlocs,RSRpks,RSRlocs)/(size(RSRpks,1))*100);j=j+1;
end
output(1,j) = (size(Wpks,1)./(still./3000));j=j+1; %pks/min in whole brain ROI


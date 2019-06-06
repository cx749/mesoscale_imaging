function [output] = spon_peaks_in_stim (rest_len,time_series)

load('movement-log');

if time_series == 1
    
  load('seedpixel_timeseries');
  time_series = time_series';
  
  for j = 1:size(time_series,2)
      
      [pks, still_period, all_pks,locs] = spon_after_stim(time_series(:,j),movement_log,rest_len);
      output(1,j) = pks./(still_period./3000);
  end
  output(1,j+1) = still_period;
  output(1,j+2) = size(movement_log,2)./500 * rest_len;
else
   

load('barrel ROI trace');
load('right barrel trace.mat')
load('VL trace.mat')
load('VR trace.mat')
load('RSL trace.mat')
load('RSR trace.mat')
load('whole brain trace')
load('stim-movement-log');

trials_moving = sum(stim_movement);

[X_pks, still_period, Xall_pks,X_locs] = spon_after_stim(X_dff,movement_log,rest_len);
[R_pks, still_periodx, Rall_pks,R_locs] = spon_after_stim(R_dff,movement_log,rest_len);
[VL_pks, still_periodx, VLall_pks,VL_locs] = spon_after_stim(VL_dff,movement_log,rest_len);
[VR_pks still_periodx, VRall_pks,VR_locs] = spon_after_stim(VR_dff,movement_log,rest_len);
[RSL_pks still_periodx, RSLall_pks,RSL_locs] = spon_after_stim(RSL_dff,movement_log,rest_len);
[RSR_pks, still_periodx, RSRall_pks,RSR_locs] = spon_after_stim(RSR_dff,movement_log,rest_len);
[W_pks , ~, Wall_pks,W_locs] = spon_after_stim(W_dff,movement_log,rest_len);

%% 'rasta' plot of L barrel spon activity

% rasta = zeros(20,400);
% 
% for a = 1:size(rasta,1) %move through row (Y-dimension) pixels
%     for b = 1:size(rasta,2) %move through columns (X-dimension) pixels
%         if 
%     end
% end
% 



%% rise times
% [Xmax_dvdt,Xmin_dvdt] = spon_rise_times(X_dff',Xall_pks,X_locs); %L barrel ROI
% [Rmax_dvdt,Rmin_dvdt] = spon_rise_times(R_dff',Rall_pks,R_locs); %R barrel ROI
% [VLmax_dvdt,VLmin_dvdt] = spon_rise_times(VL_dff',VLall_pks,VL_locs); %L visual ROI
% [VRmax_dvdt,VRmin_dvdt] = spon_rise_times(VR_dff',VRall_pks,VR_locs); %R visual ROI
% [RSLmax_dvdt,RSLmin_dvdt] = spon_rise_times(RSL_dff',RSLall_pks,RSL_locs); %L rs ROI
% [RSRmax_dvdt,RSRmin_dvdt] = spon_rise_times(RSR_dff',RSRall_pks,RSR_locs); %R rs ROI
% [Wmax_dvdt, Wmin_dvdt] = spon_rise_times(W_dff', Wall_pks, W_locs); %whole brain ROI

%%
j = 1;
output(1,j) = size(movement_log,2)./500 * rest_len;j=j+1; %(20-trials_moving)*rest_len; j=j+1;
output(1,j) = still_period;j=j+1;
output(1,j) = X_pks./(still_period./3000);j=j+1;
output(1,j) = R_pks./(still_period./3000);j=j+1;
output(1,j) = VL_pks./(still_period./3000);j=j+1;
output(1,j) = VR_pks./(still_period./3000);j=j+1;
output(1,j) = RSL_pks./(still_period./3000);j=j+1;
output(1,j) = RSR_pks./(still_period./3000);j=j+1;
output(1,j) = W_pks./(still_period./3000);j=j+1;
% output(1,j) = Xmax_dvdt;j=j+1;
% output(1,j) = Xmin_dvdt;j=j+1;
% output(1,j) = Rmax_dvdt;j=j+1;
% output(1,j) = Rmin_dvdt;j=j+1;
% output(1,j) = VLmax_dvdt;j=j+1;
% output(1,j) = VLmin_dvdt;j=j+1;
% output(1,j) = VRmax_dvdt;j=j+1;
% output(1,j) = VRmin_dvdt;j=j+1;
% output(1,j) = RSLmax_dvdt;j=j+1;
% output(1,j) = RSLmin_dvdt;j=j+1;
% output(1,j) = RSRmax_dvdt;j=j+1;
% output(1,j) = RSRmin_dvdt;j=j+1;
% output(1,j) = Wmax_dvdt;j=j+1;
% output(1,j) = Wmin_dvdt;j=j+1;
end
end




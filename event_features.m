%% *****load file location csv file as string array *****
%% rename csv to standardised variable
data_base = developmentalrecordings;

%% create blank marticies for rise-time outputs
% LB_one_rise = zeros(1,1);
% LB_two_rise = zeros(1,1);
% LB_three_rise = zeros(1,1);
% LB_five_rise = zeros(1,1);
% LB_seven_rise = zeros(1,1);
% LB_nine_rise = zeros(1,1);

%% set initial conditions 
i = 2; %start searching database at row 2 (titles in row 1)
finished = 0; %finished is a boolean output of folder_find to determine when all required files have been analysed 

%% cycle through folders and extract spontaneous even feature results 
while finished == 0
    
[finished,file,age,ID] = folder_find('spon', data_base, i);
i = i+1; 

%  need to go up to animal root folder and then back down
% load ('FOV');
% load ('barrel ROI');



load('movement-log.mat')
load('barrel trace.mat')
% load('right barrel trace.mat')
% load('VL trace.mat')
% load('VR trace.mat')
% load('RSL trace.mat')
% load('RSR trace.mat')
% load('whole brain trace')


still = size(X_dff,1)-sum(movement_log);
%% find peaks (size and location) during still periods of recording
[Xpks, Xlocs]  = find_spon_peaks(7,X_dff,movement_log); %in L barrel ROI
% [Rpks, Rlocs]  = find_spon_peaks(7,R_dff,movement_log); %in R barrel ROI
% [VLpks, VLlocs]  = find_spon_peaks(7,VL_dff,movement_log); %in L visual ROI
% [VRpks, VRlocs]  = find_spon_peaks(7,VR_dff,movement_log); %in R visual ROI
% [RSLpks, RSLlocs]  = find_spon_peaks(7,RSL_dff,movement_log); %in L restrosplenial ROI
% [RSRpks, RSRlocs]  = find_spon_peaks(7,RSR_dff,movement_log); %in R restrosplenia ROI
% [Wpks, Wlocs]  = find_spon_peaks(7,W_dff,movement_log); %in whole brain ROI

%% find max and min dvdt of waveforms
[Xmax_dvdt,Xmin_dvdt,Xmax_dvdt_ave,Xmin_dvdt_ave] = spon_rise_times(7,X_dff,Xpks,Xlocs); %L barrel ROI
% [Rmax_dvdt,Rmin_dvdt, Rmax_dvdt_ave,Rmin_dvdt_ave] = spon_rise_times(7,R_dff,Rpks,Rlocs); %R barrel ROI
% [VLmax_dvdt,VLmin_dvdt] = spon_rise_times(7,VL_dff,VLpks,VLlocs); %L visual ROI
% [VRmax_dvdt,VRmin_dvdt] = spon_rise_times(7,VR_dff,VRpks,VRlocs); %R visual ROI
% [RSLmax_dvdt,RSLmin_dvdt] = spon_rise_times(7,RSL_dff,RSLpks,RSLlocs); %R rs ROI
% [RSRmax_dvdt,RSRmin_dvdt] = spon_rise_times(7,RSR_dff,RSRpks,RSRlocs); %R rs ROI

% %
% if age == 1
%    LB_one_rise = horzcat(LB_one_rise,Xmax_dvdt);
% else if age == 2
%         LB_two_rise = horzcat(LB_two_rise,Xmax_dvdt);
%     else if age == 3
%             LB_three_rise = horzcat(LB_three_rise,Xmax_dvdt);
%         else if age == 5
%                 LB_five_rise = horzcat(LB_five_rise,Xmax_dvdt);
%             else if age == 7
%                     LB_seven_rise = horzcat(LB_seven_rise,Xmax_dvdt);
%                 else if age == 9
%                         LB_nine_rise = horzcat(LB_nine_rise,Xmax_dvdt);
% end
% end
% end
%         end
%     end
%  
% end


   

end

%% cumulative frequency graphs for rise times

% figure;hold on;
% cdfplot(LB_one_rise);
% cdfplot(LB_two_rise);
% cdfplot(LB_three_rise);
% cdfplot(LB_five_rise);
% cdfplot(LB_seven_rise);
% cdfplot(LB_nine_rise);
% legend('P1','P2','P3','P5','P7','P9');

% %% create ROI surrounding sensory ROI
% figure;imshow(frame);
% outline = cell2mat(bwboundaries(threshIdx));
% hold on
% plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);
% 
% outer = roipoly;
% adj_roi = outer - threshIdx;
% 
% %timeseries from surround ROI
% [Xadj_dff] = roi_timeseries(adj_roi,I);
%% *****load file location csv file as string array *****
%% rename imported string array to standardised variable
exist developmentalrecordings;
if ans == 1 
data_base = developmentalrecordings;
treatment_type = 0;
end
exist whiskertrimmedrecordings;
if ans == 1
data_base = whiskertrimmedrecordings;
treatment_type = 1;
treatment_list = zeros(1,1);
end


%% create blank marticies for rise-time outputs
LB_one_rise = zeros(1,1);LB_one_fall = zeros(1,1);LB_one_amp = zeros(1,1);
LB_two_rise = zeros(1,1);LB_two_fall = zeros(1,1);LB_two_amp = zeros(1,1);
LB_three_rise = zeros(1,1);LB_three_fall = zeros(1,1);LB_three_amp = zeros(1,1);
LB_five_rise = zeros(1,1);LB_five_fall = zeros(1,1);LB_five_amp = zeros(1,1);
LB_seven_rise = zeros(1,1);LB_seven_fall = zeros(1,1);LB_seven_amp = zeros(1,1);
LB_nine_rise = zeros(1,1);LB_nine_fall = zeros(1,1);LB_nine_amp = zeros(1,1);


%% set initial conditions 
i = 2; %start searching database at row 2 (titles in row 1)
finished = 0; %finished is a boolean output of folder_find to determine when all required files have been analysed 

%% cycle through folders and extract spontaneous even feature results 
while finished == 0
if treatment_type == 0    %for original developmental recordings
[finished,file,age,ID] = folder_find('spon', data_base, i, 'n');
else if treatment_type ==1      %for trimmed cohort
        [finished,file,age,ID,treatment] = folder_find('spon', data_base, i,'t');
    end
end
 

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
[Xmax_dvdt,Xmin_dvdt,Xmax_dvdt_ave,Xmin_dvdt_ave,amp] = spon_rise_times(7,X_dff,Xpks,Xlocs); %L barrel ROI
% [Rmax_dvdt,Rmin_dvdt, Rmax_dvdt_ave,Rmin_dvdt_ave] = spon_rise_times(7,R_dff,Rpks,Rlocs); %R barrel ROI
% [VLmax_dvdt,VLmin_dvdt] = spon_rise_times(7,VL_dff,VLpks,VLlocs); %L visual ROI
% [VRmax_dvdt,VRmin_dvdt] = spon_rise_times(7,VR_dff,VRpks,VRlocs); %R visual ROI
% [RSLmax_dvdt,RSLmin_dvdt] = spon_rise_times(7,RSL_dff,RSLpks,RSLlocs); %R rs ROI
% [RSRmax_dvdt,RSRmin_dvdt] = spon_rise_times(7,RSR_dff,RSRpks,RSRlocs); %R rs ROI

%
if age == 1
   LB_one_rise = horzcat(LB_one_rise,Xmax_dvdt./50);
      LB_one_fall = horzcat(LB_one_fall,Xmin_dvdt./50);
      LB_one_amp = horzcat(LB_one_amp,amp);
else if age == 2
        LB_two_rise = horzcat(LB_two_rise,Xmax_dvdt./50);
         LB_two_fall = horzcat(LB_two_fall,Xmin_dvdt./50);
         LB_two_amp = horzcat(LB_two_amp,amp);
    else if age == 3
            LB_three_rise = horzcat(LB_three_rise,Xmax_dvdt./50);
             LB_three_fall = horzcat(LB_three_fall,Xmin_dvdt./50);
             LB_three_amp = horzcat(LB_three_amp,amp);
        else if age == 5
                LB_five_rise = horzcat(LB_five_rise,Xmax_dvdt./50);
                 LB_five_fall = horzcat(LB_five_fall,Xmin_dvdt./50);
                 LB_five_amp = horzcat(LB_five_amp,amp);
            else if age == 7
                    LB_seven_rise = horzcat(LB_seven_rise,Xmax_dvdt./50);
                     LB_seven_fall = horzcat(LB_seven_fall,Xmin_dvdt./50);
                     LB_seven_amp = horzcat(LB_seven_amp,amp);
                else if age == 9
                        LB_nine_rise = horzcat(LB_nine_rise,Xmax_dvdt./50);
                         LB_nine_fall = horzcat(LB_nine_fall,Xmin_dvdt./50);
                         LB_nine_amp = horzcat(LB_nine_amp,amp);
end
end
        end
    end
 
end
end

if treatment_type == 1  
if treatment == 'n'
treatment_full = zeros(1,size(Xmax_dvdt,2)); %0 represent not trimmed
else if treatment == 't'
        treatment_full = ones(1,size(Xmax_dvdt,2)); %1 represent trimmed animals
    end
end

treatment_list = horzcat(treatment_list,treatment_full);
end

i = i+1;

end

%% kinetics of whisker stimulated events
i = 2; %start searching database at row 2 (titles in row 1)
finished = 0; %finished is a boolean output of folder_find to determine when all required files have been analysed 
% create blank marticies for rise-time outputs
stim_one_rise = zeros(1,1);stim_one_fall = zeros(1,1);
stim_two_rise = zeros(1,1);stim_two_fall = zeros(1,1);
stim_three_rise = zeros(1,1);stim_three_fall = zeros(1,1);
stim_five_rise = zeros(1,1);stim_five_fall = zeros(1,1);
stim_seven_rise = zeros(1,1);stim_seven_fall = zeros(1,1);
stim_nine_rise = zeros(1,1);stim_nine_fall = zeros(1,1);

while finished == 0

    if treatment_type == 0    %for original developmental recordings
[finished,file,age,ID] = folder_find('whisk sing', data_base, i,'n');
else if treatment_type ==1      %for trimmed cohort
        [finished,file,age,ID,treatment] = folder_find('whisk sing', data_base, i,'t');
    end
end

load('individual respose traces.mat')

for p = 1:size(f,2)
f(:,p) = low_filt(7,f(:,p)); %lowpass filter to remove heartbeat ossilations 
 rise(:,p) = diff(f(:,p));
    rise(:,p) = smooth((rise(:,p)/0.2),5);
   
    max_dvdt_stim(:,p) = max(rise(1:50,p)); %max rise time in first second of waveform (rising period)
    min_dvdt_stim(:,p) = min(rise(51:100,p)); %max fall time in second second of waveform (falling period)

end
if age == 1
   stim_one_rise = horzcat(stim_one_rise, max_dvdt_stim./50);
   stim_one_fall = horzcat(stim_one_fall, min_dvdt_stim./50);
else if age == 2
        stim_two_rise = horzcat(stim_two_rise, max_dvdt_stim./50);
        stim_two_fall = horzcat(stim_two_fall, min_dvdt_stim./50);
    else if age == 3
            stim_three_rise = horzcat(stim_three_rise, max_dvdt_stim./50);
            stim_three_fall = horzcat(stim_three_fall, min_dvdt_stim./50);
        else if age == 5
                stim_five_rise = horzcat(stim_five_rise, max_dvdt_stim./50);
                stim_five_fall = horzcat(stim_five_fall, min_dvdt_stim./50);
            else if age == 7
                    stim_seven_rise = horzcat(stim_seven_rise, max_dvdt_stim./50);
                    stim_seven_fall = horzcat(stim_seven_fall, min_dvdt_stim./50);
                else if age == 9
                        stim_nine_rise = horzcat(stim_nine_rise, max_dvdt_stim./50);
                        stim_nine_fall = horzcat(stim_nine_fall, min_dvdt_stim./50);
end
end
end
        end
    end
 
end
i = i+1;
end
%% cumulative frequency graphs for rise times stim vs spon
if treatment_type == 0    %for original developmental recordings
figure;
subplot(2,3,1);hold on;cdfplot(LB_one_rise);cdfplot(stim_one_rise);title('P1');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,2);hold on;cdfplot(LB_two_rise);cdfplot(stim_two_rise);title('P2');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,3);hold on;cdfplot(LB_three_rise);cdfplot(stim_three_rise);title('P3');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,4);hold on;cdfplot(LB_five_rise);cdfplot(stim_five_rise);title('P5');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,5);hold on;cdfplot(LB_seven_rise);cdfplot(stim_seven_rise);title('P7');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,6);hold on;cdfplot(LB_nine_rise);cdfplot(stim_nine_rise);title('P9');xlabel('df/f% per second');ylabel('cum freq');
legend('spon', 'stim','location','southeast');legend('boxoff'); suptitle('Max-dvdt');

figure;
subplot(2,3,1);hold on;cdfplot(LB_one_fall);cdfplot(stim_one_fall);title('P1');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,2);hold on;cdfplot(LB_two_fall);cdfplot(stim_two_fall);title('P2');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,3);hold on;cdfplot(LB_three_fall);cdfplot(stim_three_fall);title('P3');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,4);hold on;cdfplot(LB_five_fall);cdfplot(stim_five_fall);title('P5');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,5);hold on;cdfplot(LB_seven_fall);cdfplot(stim_seven_fall);title('P7');xlabel('df/f% per second');ylabel('cum freq');
subplot(2,3,6);hold on;cdfplot(LB_nine_fall);cdfplot(stim_nine_fall);title('P9');xlabel('df/f% per second');ylabel('cum freq');
legend('spon', 'stim','location','northwest');legend('boxoff'); suptitle('Min-dvdt');

figure;hold on;cdfplot(LB_one_rise);cdfplot(LB_two_rise);cdfplot(LB_three_rise);
cdfplot(LB_five_rise);cdfplot(LB_seven_rise);cdfplot(LB_nine_rise);legend('P1', 'P2','P3','P5','P7','P9');title('Spontaneous event rise times');xlabel('df/f% per second');ylabel('cum freq');

figure;hold on;cdfplot(LB_one_fall);cdfplot(LB_two_fall);cdfplot(LB_three_fall);
cdfplot(LB_five_fall);cdfplot(LB_seven_fall);cdfplot(LB_nine_fall);legend('P1', 'P2','P3','P5','P7','P9', 'location','northwest');title('Spontaneous event fall times');xlabel('df/f% per second');ylabel('cum freq');

figure;hold on;cdfplot(LB_one_amp);cdfplot(LB_two_amp);cdfplot(LB_three_amp);
cdfplot(LB_five_amp);cdfplot(LB_seven_amp);cdfplot(LB_nine_amp);legend('P1', 'P2','P3','P5','P7','P9', 'location','southeast');title('Spontaneous event amplitudes');xlabel('df/f% per second');ylabel('cum freq');


figure;hold on;cdfplot(stim_one_rise);cdfplot(stim_two_rise);
cdfplot(stim_three_rise);cdfplot(stim_five_rise);cdfplot(stim_seven_rise);cdfplot(stim_nine_rise);legend('P1', 'P2','P3','P5','P7','P9');title('Stimulated event rise times');xlabel('df/f% per second');ylabel('cum freq');

figure; 
subplot(2,3,1);hold on;scatter(LB_one_fall,LB_one_rise);lsline;scatter(stim_one_fall,stim_one_rise);lsline;title('P1');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
subplot(2,3,2); hold on;scatter(LB_two_fall,LB_two_rise);lsline;scatter(stim_two_fall,stim_two_rise);lsline;title('P2');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
subplot(2,3,3); hold on;scatter(LB_three_fall,LB_three_rise);lsline;scatter(stim_three_fall,stim_three_rise);lsline;title('P3');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
subplot(2,3,4);hold on;scatter(LB_five_fall,LB_five_rise);lsline;scatter(stim_five_fall,stim_five_rise);lsline;title('P5');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
subplot(2,3,5); hold on;scatter(LB_seven_fall,LB_seven_rise);lsline;scatter(stim_seven_fall,stim_seven_rise);lsline;title('P7');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
subplot(2,3,6); hold on;scatter(LB_nine_fall,LB_nine_rise);lsline;scatter(stim_nine_fall,stim_nine_rise);lsline;title('P9');xlabel('falling (df/f% per second)');ylabel('rising (df/f% per second)');
suptitle('Max-dvdt:Min-dvdt correlation');%legend('spon', 'spon ls', 'stim', 'stim ls','location','southwest');legend('boxoff');

figure; 
subplot(2,3,1);hold on;scatter(LB_one_amp,LB_one_rise);lsline;title('P1');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
subplot(2,3,2); hold on;scatter(LB_two_amp,LB_two_rise);lsline;title('P2');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
subplot(2,3,3); hold on;scatter(LB_three_amp,LB_three_rise);lsline;title('P3');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
subplot(2,3,4);hold on;scatter(LB_five_amp,LB_five_rise);lsline;title('P5');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
subplot(2,3,5); hold on;scatter(LB_seven_amp,LB_seven_rise);lsline;title('P7');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
subplot(2,3,6); hold on;scatter(LB_nine_amp,LB_nine_rise);lsline;title('P9');xlabel('amplitude(df/f%)');ylabel('rising (df/f% per second)');
suptitle('Max-dvdt:amplitude correlation');%legend('spon', 'spon ls', 'stim', 'stim ls','location','southwest');legend('boxoff');



end
%% consolidate all spontaneous results into a single 'master' matrix to run cluster analysis 
if treatment_type == 0    %for original developmental recordings

%first column is age of animal the event is from
age = ones(size(LB_one_fall(:,2:end), 2),1)*1;features = vertcat(age, ones(size(LB_two_fall(:,2:end), 2),1)*2,ones(size(LB_three_fall(:,2:end), 2),1)*3,ones(size(LB_five_fall(:,2:end), 2),1)*5,ones(size(LB_seven_fall(:,2:end), 2),1)*7,ones(size(LB_nine_fall(:,2:end), 2),1)*9);

%add max_dvdt to column 1
features(:,2) = vertcat(LB_one_rise(:,2:end)',LB_two_rise(:,2:end)',LB_three_rise(:,2:end)',LB_five_rise(:,2:end)',LB_seven_rise(:,2:end)',LB_nine_rise(:,2:end)');
%add min_dvdt to column 2
features(:,3) = vertcat(LB_one_fall(:,2:end)',LB_two_fall(:,2:end)',LB_three_fall(:,2:end)',LB_five_fall(:,2:end)',LB_seven_fall(:,2:end)',LB_nine_fall(:,2:end)');
%add amplitude to column 3
features(:,4) = vertcat(LB_one_amp(:,2:end)',LB_two_amp(:,2:end)',LB_three_amp(:,2:end)',LB_five_amp(:,2:end)',LB_seven_amp(:,2:end)',LB_nine_amp(:,2:end)');

figure;boxplot(features(:,2),features(:,1));title('Max-dvdt');xlabel('age');ylabel('df/f% per second');
figure;boxplot(features(:,3),features(:,1));title('Min-dvdt');xlabel('age');ylabel('df/f% per second');
figure;boxplot(features(:,4),features(:,1));title('Amplitude');xlabel('age');ylabel('df/f%');

else if treatment_type == 1    %for whisker trimmed cohort
    %first column is age of animal the event is from
age = ones(size(LB_three_fall(:,2:end), 2),1)*3;features = vertcat(age, ones(size(LB_seven_fall(:,2:end), 2),1)*7);
features(:,2) = treatment_list(:,2:end);
features(:,3) = vertcat(LB_three_rise(:,2:end)',LB_seven_rise(:,2:end)');
features(:,4) = vertcat(LB_three_fall(:,2:end)',LB_seven_fall(:,2:end)');

for i = 1:size(features,1)
    if features(i,1) == 3 && features(i,2) == 0
    N3(i,:) = features(i,:);    
    else if features(i,1) == 3 && features(i,2) == 1
            T3(i,:) = features(i,:); 
    else if features(i,1) == 7 && features(i,2) == 0
            N7(i,:) = features(i,:);
    else if features(i,1) == 7 && features(i,2) == 1
            T7(i,:) = features(i,:);
    end
end
        end
    end
end

N3(N3 == 0) = NaN;
T3(T3 == 0) = NaN;
N7(N7 == 0) = NaN;
T7(T7 == 0) = NaN;

figure;
subplot(1,2,1);hold on;cdfplot(N3(:,3));cdfplot(T3(:,3)); title('P3 spontaneous max-dvdt');xlabel('df/f% per second');ylabel('cum freq');legend('Not', 'Trimmed');
subplot(1,2,2);hold on;cdfplot(N7(:,3));cdfplot(T7(:,3));title('P7 spontaneous max-dvdt');xlabel('df/f% per second');ylabel('cum freq');legend('Not', 'Trimmed');
figure;
subplot(1,2,1);hold on;cdfplot(N3(:,4));cdfplot(T3(:,4)); title('P3 spontaneous min-dvdt');xlabel('df/f% per second');ylabel('cum freq');legend('Not', 'Trimmed','location','northwest');
subplot(1,2,2);hold on;cdfplot(N7(:,4));cdfplot(T7(:,4));title('P7 spontaneous min-dvdt');xlabel('df/f% per second');ylabel('cum freq');legend('Not', 'Trimmed','location','northwest');

end
end




% [h,p] = kstest2(N3(:,3),T3(:,3));
% [h,p] = kstest2(N7(:,3),T7(:,3));
% 
% [h, p]= ttest2(N3(:,3),T3(:,3));
%% k-mean cluster analysis
clust = 10; %number of clusters

%check for number of clusters using sum of squares to assess elbow
for c = 1:clust
  [idx,C,sumd] = kmeans(features(:,2:4),c); %k means using Max and Min dvdt and amp
  totSum(c) = sum(sumd);
end
figure;plot(totSum);


%run kmeans cluster
[idx,C,sumd] = kmeans(features(:,2:4),clust);

%visualise
figure;
subplot(3,1,1);hold on;
for c = 1:clust;
plot(features(idx==c,1),features(idx==c,2),'o');
end
ylabel('max-dvdt');xlabel('age');
% plot(features(idx==2,1),features(idx==2,2),'b.','MarkerSize',12);
% plot(features(idx==3,1),features(idx==3,2),'g.','MarkerSize',12);plot(C(:,1),C(:,2),C(:,3),'kx');
% 
subplot(3,1,2);gscatter(features(:,2),features(:,3),idx);xlabel('max-dvdt');ylabel('min-dvdt');
subplot(3,1,3);gscatter(features(:,2),features(:,4),idx);xlabel('max-dvdt');ylabel('amp');

%% create ROI surrounding sensory ROI
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
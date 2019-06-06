%% *****load file location csv file as string array *****

%% **** change name to data base
data_base = developmentalrecordings; %whiskertrimmedrecordings; %
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'whisk sing')); %find location of whisk sing files in file record matrix


for i = 37:(size(ind,1)+1) %P3 starts at 19
    
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

load('movement-log')
load('barrel trace')

still = size(X_dff,1)-sum(movement_log);
output = spon_basics(); %%%%%%%% ***** code means X_dff in wrong orientation ******* FIX
%output = time_series_basics();
%% ages 
file = char(data_base((ind(i-1,1)),2));
age = str2num(file(2));
ID = str2num(file(end));
% 
output(1,1) = age;  
output(1,2) = ID;
% output(1,2) = i; 
%output(i,1) = size(X_dff, 1);
%output(i,2) = still;
spon_basics_results(i,:) = output; %output file into matrix of results;

end

% %%% seedpixel correlations
%   k = 1;
% output(1,1) = corr(time_series(k,:)', time_series(k+1,:)'); k = k+2;
% output(1,2) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,3) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,4) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,5) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,6) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,7) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,8) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
% output(1,9) = corr(time_series(k,:)', time_series(2,:)'); k = k+2;
%%%% ROi correlations
% load('barrel ROI trace.mat')
% load('right barrel trace.mat')
% load('VL trace.mat')
% load('VR trace.mat')
% load('RSL trace.mat')
% load('RSR trace.mat')
% 
% output(1,1) = corr(R_dff, X_dff);
% output(1,2) = corr(VR_dff, VL_dff);
% output(1,3) = corr(RSR_dff, RSL_dff);

%%%%%%%%%%

%     j = 1;
% cd (char(data_base(2,1))); %go to main root directory
% cd(char(data_base((ind(i-1,1)),2))); %go to current file directory
% 
% load('whole brain trace')
% load('barrel ROI trace.mat')
% load('right barrel trace.mat')
% load('VL trace.mat')
% load('VR trace.mat')
% load('RSL trace.mat')
% load('RSR trace.mat')
% load('whole brain trace')
% load('movement-log.mat')
% 
% still = size(W_dff,1)-sum(movement_log);
% 
% [Xpks, Xlocs]  = find_spon_peaks(X_dff,movement_log); %in L barrel ROI
% [Rpks, Rlocs]  = find_spon_peaks(R_dff,movement_log); %in R barrel ROI
% [VLpks, VLlocs]  = find_spon_peaks(VL_dff,movement_log); %in L visual ROI
% [VRpks, VRlocs]  = find_spon_peaks(VR_dff,movement_log); %in R visual ROI
% [RSLpks, RSLlocs]  = find_spon_peaks(RSL_dff,movement_log); %in L restrosplenial ROI
% [RSRpks, RSRlocs]  = find_spon_peaks(RSR_dff,movement_log); %in R restrosplenia ROI
% [Wpks, Wlocs]  = find_spon_peaks(W_dff,movement_log); %in whole brain ROI
% 
% output (1,j) = (size(Wpks,1)./(still./3000));j=j+1;
% output(1,j) = (size(Xpks,1)./(still./3000));j=j+1; 
% output(1,j) = (size(Rpks,1)./(still./3000));j=j+1; 
% output(1,j) = (size(VLpks,1)./(still./3000));j=j+1; 
% output(1,j) = (size(VRpks,1)./(still./3000));j=j+1; 
% output(1,j) = (size(RSLpks,1)./(still./3000));j=j+1; 
% output(1,j) = (size(RSRpks,1)./(still./3000));j=j+1; 
% 
% spon_basics_results(i,:) = output;


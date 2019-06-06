%% *****load file location csv file as string array *****

%% **** change name to data base
data_base = developmentalrecordings;
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'whisk sing')); %find location of whisk sing files in file record matrix

for z = 2:(size(ind,1)+1)
    
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(z-1,1)),2))); %go to current file directory


load('barrel trace');
load('movement-log.mat');

%extract stimulation waveforms
X = low_filt(1,X_dff); %smooth trace with 1hz lowpass filter
k = 50;

for i = 1:20
f(:,i) = X((k-49):(k+100),:);
k = k+500;
end

%get mean height

for i = 1:20
B0(1,i) = mean(f(1:10,i));
M(1,i) = max(f(20:80,i));
heights(1,i) = M(1,i)-B0(1,i);
end

output(1,1) = max(heights);

%rise and fall time
for i = 1:size(f,2)
    rise(:,i) = diff(f(:,i));
    rise(:,i) = smooth((rise(:,i)/0.2),5);
end

max_dvdt = max(rise(1:50,:)); %max rise time in first second of waveform (rising period)
min_dvdt = min(rise(50:100,:)); %min rise time in last second of waveform (falling period)

output(1,2) = max(max_dvdt);
output(1,3) = max(min_dvdt);

stim_timeseries_results(z,:) = output;
end



function [output] = peak_characteristics(data_base,type)
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'spon')); %find location of files in file record matrix

k=1;
for i = 2:(size(ind,1)+1)
    
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

if type == 'X'
    load('barrel trace')
elseif  type == 'R'
load('right barrel trace.mat')
X_dff = R_dff;
elseif type == 'VL'
    load('VL trace.mat')
    X_dff = VL_dff;
elseif type == 'VR'
    load('VR trace.mat')
    X_dff = VR_dff;
end

load('movement-log.mat')

[Xpks, Xlocs]  = find_spon_peaks(X_dff,movement_log); %in L barrel ROI

f = wave_form_extraction(X_dff,Xlocs);

% height
B0 = mean(f(1:10,:));
M = max(f(20:80,:));
heights = M-B0;

% rise time
for m = 1:size(f,2)
    rise(:,m) = diff(f(:,m));
    rise(:,m) = smooth((rise(:,m)/0.2),5);
end

max_dvdt = max(rise(1:50,:));
clear rise

% width ?

%ages 
file = char(data_base((ind(i-1,1)),2));
age = str2num(file(2));

%any miss match in size
miss = (size(Xlocs,1) - size(heights,2))+1;
%output
j = 1;
output(k:k+(size(Xpks,1)-miss),j) = age; j=j+1; %age
output(k:k+(size(Xpks,1)-miss),j) = i;j=j+1;%ID
output(k:k+(size(Xpks,1)-miss),j) = heights;j=j+1;%height
output(k:k+(size(Xpks,1)-miss),j) = max_dvdt;j=j+1;%risetimes


k = k+size(Xpks,1);
end
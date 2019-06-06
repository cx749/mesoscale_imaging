data_base = developmentalrecordings;
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'spon')); %find location of whisk sing files in file record matrix

for i = 37:(size(ind,1)+1)
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

exist 'left hem trace.mat';

if ans == 0

% load TIFFs and concatinate into 
I = database_file_load(i,data_base,ind);

%load hem ROIs
load('L hemisphere ROI');
load('R hemisphere ROI');

% extract and save ROI timeseries
[LH_dff] = roi_timeseries(L,I);
save ('left hem trace', 'LH_dff');
[RH_dff] = roi_timeseries(R,I);
save ('right hem trace', 'RH_dff');
else
end
end

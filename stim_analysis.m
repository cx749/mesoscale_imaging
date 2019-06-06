%% *****load file location csv file as string array *****
 
%% **** change name to data base
data_base = developmentalrecordings;  

%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'whisk sing')); %find location of whisk sing files in file record matrix


for i = 54:(size(ind,1)+1);
    
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory
    
% 
if (data_base(ind(i-1,1),5)) == 'y' %if own-trace column is n then go to main folder to load ROIs
load ('whole brain ROI'); %get BW from main folder
else
cd ../
load ('whole brain ROI'); %get BW from main folder
end

cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

load('movement-log');

I = database_file_load(i,data_base,ind); %load image files

 
%check ROI is correct
roi_disp = sum(I,3);
figure;
imagesc(roi_disp);axis tight; axis equal; colormap(gray)
outline = cell2mat(bwboundaries(BW)); %create outline of whole brain ROI
hold on
plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1);
title(ind((i-1),:));

% determine which stimulations animal moved on
B0 = linspace(500,10000,20); %end of each stim trial
stim_movement = zeros(20,1);

%Split timeseries into individual stim trials
for w = 1:20;
r1 = (B0(1,w)-499);
r2 = (B0(1,w)-475);
r3 = (B0(1,w)-1);

if sum(movement_log(:,r2:(r2+50))) > 0 %if movement during the 1 sec post stimlus
    stim_movement(w,1) = 1; 
else
     stim_movement(w,1) = 0; 
end
end
% save ('stim-movement-log', 'stim_movement');
% 
%run basic whisker stimulation analysis 
stim_heatmap(I,BW);
stim_create_roi('n');

% 
if sum(stim_movement) < 20
still_stim_heatmap(I,BW,stim_movement); 

stim_create_roi('still');

stim_activity(I,'still');

output = stim_results(BW, 'still ROI activation');


%% ages 
file = char(data_base((ind(i-1,1)),2));
age = str2num(file(2));

output(1,1) = age;  
output(1,2) = i; 
output(1,3) = 20 - sum(stim_movement);
%%
whisker_array_results(i,:) = output; %output file into matrix of results;
else
whisker_array_results(i,:) = NaN;  
end


end
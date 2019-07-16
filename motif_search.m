%% type of files for analysis 

type = 'spon';

%% identifiy database and standarise formating
exist developmentalrecordings;
if ans == 1 
data_base = developmentalrecordings;
treatment_type = 0;
end

exist whiskertrimmedrecordings;
if ans == 1
data_base = whiskertrimmedrecordings;
treatment_type = 1;
end


ind=find(ismember(data_base(:,3),type)); %find location of whisk sing files in file record matrix

%% set initial conditions for database searching 
%i = 2; %start searching database at row 2 (titles in row 1)
finished = 0; %finished is a boolean output of folder_find to determine when all required files have been analysed 

%set temporal filtering bands (in Hz)
high = 0.1;
low = 7;
%% cycle through folders and extract spontaneous even feature results 
while finished == 0
if treatment_type == 0    %for original developmental recordings
[finished,file,age,ID] = folder_find(type, data_base, i, 'n');
else if treatment_type ==1      %for trimmed cohort
        [finished,file,age,ID,treatment] = folder_find(type, data_base, i,'t');
    end
end

 I = database_file_load(i,data_base,ind);

 load('mean_lows');

 I = preprocessing_stack(I,mean_lows,high,low,'butter');

cd ..\
load('seedpixel-locations');
load('barrel_map');

if treatment_type == 0    %for original developmental recordings
[finished,file,age,ID] = folder_find(type, data_base, i, 'n');
else if treatment_type ==1      %for trimmed cohort
        [finished,file,age,ID,treatment] = folder_find(type, data_base, i,'t');
    end
end

pixel = seedpixels(1,:);

Lbarrel_corr_map = seedpixel_corr_maps(pixel, I);
save('Lbarrel_corr_map.mat', 'Lbarrel_corr_map')
figure; imagesc(Lbarrel_corr_map);colormap(jet);colorbar;
title(file);
saveas(gcf, 'Lbarrel_corr_map.tif');

    [matches,motifs,motif_pks,motif_locs] = motif_correlation(I,barrel_map,0.5);
    

motif_meta(1,:) = motif_locs;
motif_meta(2,:) = motif_pks;

save('motif_matches.mat', 'matches');
save('motif_frames.mat', 'motifs');
save('motif_meta.mat', 'motif_meta');

clear motif_meta

i = i+1;
end
 



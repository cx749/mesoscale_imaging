function [finished,file,age,ID] = folder_find(type, data_base, i)
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),type)); %find location of specified file types in specified database

cd (char(data_base(2,1))); %go to main root directory

cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

file = char(data_base((ind(i-1,1)),2));

age = str2num(file(2));
ID = char(data_base((ind(i-1,1)),7));

%finished yet?
finished = i > (size(ind,1));
end

function [finished,file,age,ID,treatment] = folder_find(type, data_base, i, treat)
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),type)); %find location of specified file types in specified database

cd (char(data_base(2,1))); %go to main root directory

cd(char(data_base((ind(i-1,1)),2))); %go to current file directory
file = char(data_base((ind(i-1,1)),2));

if treat == 't'
    age =str2num(data_base((ind(i-1,1)),8));
else
age = str2num(file(2));
end


ID = char(data_base((ind(i-1,1)),7));
treatment = (data_base((ind(i-1,1)),6));

%finished yet?
finished = i > (size(ind,1));
end

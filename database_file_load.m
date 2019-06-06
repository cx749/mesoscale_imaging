function I = database_file_load(i,data_base,ind)


cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

% check all files required are in folder

% load TIFFs and concatinate into single 3D matrix
file = char(data_base((ind(i-1,1)),2));
location_A = strfind(char(data_base((ind(i-1,1)),2)),'A');
file = file(location_A:end);

%if 5th tiff file is in folder use long_cat function
if exist(fullfile(cd, [file,'_MMstack_4.ome.tif']), 'file') ==2
fname = [file,'_MMstack.ome'];
fname2 = [file,'_MMstack_1.ome'];
fname3 = [file,'_MMstack_2.ome'];
fname4 = [file,'_MMstack_3.ome'];
fname5 = [file,'_MMstack_4.ome'];

I = long_cat(fname, fname2, fname3, fname4, fname5);

%else use TIFFcat function
else
fname = [file,'_MMstack.ome'];
fname2 = [file,'_MMstack_1.ome'];
fname3 = [file,'_MMstack_2.ome'];

I = TIFFcat_downsize(fname, fname2, fname3);

end

end

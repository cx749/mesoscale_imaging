%%Half the pixel resolution of each image and concatinate the three tiff
%%files (making up one experimental run)

function I = TIFFcat_downsize(fname, fname2, fname3)

Ia = loadtiff([fname '.tif']);  %load tiff one
Ia = imresize(Ia, 0.5, 'bilinear'); %half the pixel resolution of each image
Ib = loadtiff([fname2 '.tif']); %load tiff two
Ib = imresize(Ib, 0.5, 'bilinear'); %half the pixel resolution of each image
Itemp = cat(3, Ia, Ib); %concatinate tiff one and two into I
clear Ia Ib
Ic = loadtiff([fname3 '.tif']); %load tiff three
Ic = imresize(Ic, 0.5, 'bilinear'); %half the pixel resolution of image
I = cat(3, Itemp, Ic); %Add tiff three into I

end


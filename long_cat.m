%%Half the pixel resolution of each image and concatinate the 5 tiff
%%files (making up one experimental run)

function I = long_cat(fname, fname2, fname3, fname4, fname5)
Ia = loadtiff([fname '.tif']);  %load tiff one
Ia = imresize(Ia, 0.5, 'bilinear'); %half the pixel resolution of each image
Ib = loadtiff([fname2 '.tif']); %load tiff two
Ib = imresize(Ib, 0.5, 'bilinear'); %half the pixel resolution of each image
Itemp = cat(3, Ia, Ib); %concatinate tiff one and two into I
clear Ia Ib
Ic = loadtiff([fname3 '.tif']); %load tiff three
Ic = imresize(Ic, 0.5, 'bilinear'); %half the pixel resolution of image
Id = loadtiff([fname4 '.tif']); %load tiff four
Id = imresize(Id, 0.5, 'bilinear'); %half the pixel resolution of image
I = cat(3, Itemp, Ic,Id); %Add tiff three into I
clear Ic Id
Ie = loadtiff([fname5 '.tif']); %load tiff five
Ie = imresize(Ie, 0.5, 'bilinear'); %half the pixel resolution of image
I = cat(3, I, Ie); %Add tiff three into I
clear Ie
end
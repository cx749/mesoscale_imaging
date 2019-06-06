I = loadtiff('A_2_MMStack_2.ome.tif');
I = imresize(I, 0.5, 'bilinear'); %half the pixel resolution of image


BW = create_ROIs(I);

cd ../

save ('whole brain ROI', 'BW');

frame = mean(I,3);

save ('FOV', 'frame');


load('seedpixel-locations.mat')
load('whole brain ROI.mat')

%calculate average midline position on x-axis
imshow(BW);
[x,y] = getpts;
midline = average(x);

for i = 1:9  
    distance(i,1) = midline - seedpixels(i,1);  
 end

for i = 10:18
    distance(i,1) = seedpixels(i,1) - midline;  
end

%Average right and left region distance

for i = 1:9 
ave_distance(i,1) = ((distance(i,1) + distance(i+9,1))./2);
end

%% correlation between distance and bilateral correlation in seedpixel ROI

%go to spontaneous recording folder

load('corr_matrix.mat')

%(1,2) = barrel
% (3,4) = forelimb
% (5,6) = hindlimb
% (7,8) = m1
% (9,10) = m2
% (11,12) = V1
% (13,14) = RS
% (15,16) = PPC
% (17,18) = A 

figure; hold on;

for i = 1:9
scatter (ave_distance (i,:), corr_matrix(i,i+2));
end

%load files from main session directory
load('FOV')
load('whole brain ROI');
load('barrel ROI');
load('R barrel ROI');

%frame = sum(I,3);
%figure of FOV 
figure; set(gcf, 'Position', [400, 300, 1000, 600]) %position and size to cmc dell monitor
imagesc(frame);axis tight; axis equal; colormap(gray) %image of FOV 
hold on

%add barrel ROIs to guide seedpixel location
exist threshIdx;
if ans == 1
outline = cell2mat(bwboundaries(threshIdx)); %create outline of barrel ROI
outline2 = cell2mat(bwboundaries(BW)); %create outline of whole brain ROI
plot(outline(:, 2), outline(:, 1), 'w', 'linewidth', 1); %plot barrel ROI outline
plot(outline2(:, 2), outline2(:, 1), 'w', 'linewidth', 1); %plot whole brain ROI outline
else
end

i = 1;
%mark left hemisphere seedpixels [image title informs which one to do]
title('barrel')
[lbx,lby] = getpts; %left barrel location
seedpixels(i,1) = lbx; %add to seedpixel matrix
seedpixels(i,2) = lby;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('auditory')
[lax,lay] = getpts; %left auditory ctx location
seedpixels(i,1) = lax;
seedpixels(i,2) = lay;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('visual')
[lvx,lvy] = getpts; %left visual ctx location
seedpixels(i,1) = lvx;
seedpixels(i,2) = lvy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('retrospenial')
[lrsx,lrsy] = getpts; %left retrosplenial ctx location
seedpixels(i,1) = lrsx;
seedpixels(i,2) = lrsy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1;%mark on image
title('ppc')
[lppcx,lppcy] = getpts; %left posterior parietal ctx location
seedpixels(i,1) = lppcx;
seedpixels(i,2) = lppcy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('hindlimb')
[lhlx,lhly] = getpts; %left hindlimb ctx location
seedpixels(i,1) = lhlx;
seedpixels(i,2) = lhly;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('forelimb')
[lflx,lfly] = getpts; %left forelimb ctx location
seedpixels(i,1) = lflx;
seedpixels(i,2) = lfly;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('M1')
[lm1x,lm1y] = getpts; %left M1 location
seedpixels(i,1) = lm1x;
seedpixels(i,2) = lm1y;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('M2')
[lm2x,lm2y] = getpts; %left M2 location
seedpixels(i,1) = lm2x;
seedpixels(i,2) = lm2y;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image


%mark right hemisphere seedpixels [image title informs which one to do]
title('barrel')
[rbx,rby] = getpts; %right barrel location
seedpixels(i,1) = rbx; %add to seedpixel matrix
seedpixels(i,2) = rby;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('auditory')
[rax,ray] = getpts; %right auditory ctx location
seedpixels(i,1) = rax;
seedpixels(i,2) = ray;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('visual')
[rvx,rvy] = getpts; %right visual ctx location
seedpixels(i,1) = rvx;
seedpixels(i,2) = rvy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('retrospenial')
[rrsx,rrsy] = getpts; %right retrosplenial ctx location
seedpixels(i,1) = rrsx;
seedpixels(i,2) = rrsy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1;%mark on image
title('ppc')
[rppcx,rppcy] = getpts; %right posterior parietal ctx location
seedpixels(i,1) = rppcx;
seedpixels(i,2) = rppcy;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('hindlimb')
[rhlx,rhly] = getpts; %right hindlimb ctx location
seedpixels(i,1) = rhlx;
seedpixels(i,2) = rhly;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('forelimb')
[rflx,rfly] = getpts; %right forelimb ctx location
seedpixels(i,1) = rflx;
seedpixels(i,2) = rfly;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('M1')
[rm1x,rm1y] = getpts; %right M1 location
seedpixels(i,1) = rm1x;
seedpixels(i,2) = rm1y;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image
title('M2')
[rm2x,rm2y] = getpts; %right M2 location
seedpixels(i,1) = rm2x;
seedpixels(i,2) = rm2y;
scatter(seedpixels(i,1),seedpixels(i,2));i = i+1; %mark on image

seedpixels = uint16(seedpixels); %convert from double to intergers 

save('seedpixel-locations', 'seedpixels'); %save seedpixel location matrix

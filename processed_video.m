function [] = processed_video(I)%name for file)

% 
ma = max(I);ma = max(ma);ma = max(ma);
mi = min(I);mi = min(mi);mi = min(mi);
clims = [mi ma];

%create 
video = VideoWriter('slow-wave-cheby.avi'); %create the video object
open(video); %open the file for writing
for f=1:1000%size(I,3) %where N is the number of images
     figure('visible','off');imagesc(I(:,:,f),clims);
     F = getframe;
  writeVideo(video,F); %write the image to file
end
close(video); %close the file
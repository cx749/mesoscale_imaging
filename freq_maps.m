Fs = 50;
N = size(I,3);
%I = imgaussfilt(I,4);
load('whole brain ROI')

tic
high = 5;
low = 50;
for i = 1:size(I,1)
    for j = 1:size(I,2)
      if BW(i,j) == 1   
    y = seedpixel(I,j,i,low,high);
    ydft = fft(y);
    ydft = ydft(1:N/2+1);
    psdy = (1/(Fs*N)) * abs(ydft).^2;
    psdy(2:end-1) = 2*psdy(2:end-1);
    %psdy = psdy./max(psdy);
    freq = 0:Fs/length(y):Fs/2;
    [r c] = max(psdy);
      freq_map(i,j) = r;
      else
      freq_map(i,j) = 0;
      end
end
end
%clims = [0 1];
figure;imagesc(freq_map);colormap(jet);colorbar;
% freq_map = freq_map./max(freq_map);
% figure;imagesc(freq_map,clims);colormap(jet);colorbar;
toc

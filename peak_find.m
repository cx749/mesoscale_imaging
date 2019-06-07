function [pks,locs,w,p] = peak_find(lpf,dff,TH,fig)
X = low_filt(lpf,dff); %lowpass filter time series

[pks,locs,w,p] = findpeaks(X,'MinPeakProminence',TH); %
if fig == true
    peak_fig(X,locs,pks,TH);
end

%%
function peak_fig(dff,locs,pks,TH)
figure
findpeaks(dff,'MinPeakProminence',TH); %plot trace with peaks marked
text(locs+.02,pks,num2str((1:numel(pks))')); %label peaks with numbers
end
end


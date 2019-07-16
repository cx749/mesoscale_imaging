function [pks, locs]  = find_spon_peaks(lpf,X_dff,movement_log,fig)
X_dff = high_filt(0.1,X_dff); % high pass filter at 0.1;

exist fig;
if ans == 0 
    fig = 0;
end

[Xpks,Xlocs] = peak_find(lpf,X_dff,1,fig);


k = 1;
 
for i = 1:size(Xpks,1)
    if movement_log(:,(Xlocs(i,:))) == 0 
        pks(k,1) = Xpks(i,:);
        locs(k,1) = Xlocs(i,:);
        k = k+1;
    else
end
end

exist pks;

if ans == 0
  pks(1,1) = 0;
  locs(1,1) = 0;  
 
else 
 
end

end


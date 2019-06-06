function f = wave_form_extraction(X_dff,Xlocs)

X = low_filt(1,X_dff); %smooth trace with 1hz lowpass filter
%X = X_dff;
%extract each event waveform 
for i = 1:size(Xlocs,1)
    if Xlocs(i,:) < 51 || Xlocs(i,:) >(size(X_dff,2)-50)
    else
    f(:,i) = X(:,(Xlocs(i,:)-50):((Xlocs(i,:)+50)));
    end
end
end


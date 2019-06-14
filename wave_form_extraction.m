function f = wave_form_extraction(X_dff,Xlocs)

%X = X_dff;
%extract each event waveform 
for i = 1:size(Xlocs,1)
    if Xlocs(i,:) < 51 || Xlocs(i,:) >(size(X_dff,1)-50)
        else
    f(:,i) = X_dff((Xlocs(i,:)-50):((Xlocs(i,:)+50)),:);
    end
end
end


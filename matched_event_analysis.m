data_base = whiskertrimmedrecordings; %developmentalrecordings; %
%% find folder and load TIFF files
ind=find(ismember(data_base(:,3),'spon')); %find location of whisk sing files in file record matrix


for i = 2:(size(ind,1)+1)
    
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory

load('barrel ROI trace')
load('right barrel trace')
load('movement-log')

[LHpks,LHlocs] = find_spon_peaks(X_dff,movement_log);
[RHpks,RHlocs] = find_spon_peaks(R_dff,movement_log);

match = matched_peaks(5,LHpks,LHlocs,RHpks,RHlocs);

if size(LHpks, 1) > size(RHpks, 1)
    output(i,1) =  (match./(size(LHpks, 1))*100);
else
    output(i,1) =  (match./(size(RHpks, 1))*100);
end


% load('seedpixel_timeseries')
%   k = 1;
%   
% for z = 1:9
% [Lpks,Llocs] = find_spon_peaks(time_series(k,:)',movement_log);
% [Rpks,Rlocs] = find_spon_peaks(time_series(k+1,:)',movement_log);
% 
% match = matched_peaks(5,Lpks,Llocs,Rpks,Rlocs);
% 
% if size(Lpks, 1) > size(Rpks, 1)
%    time_S(i,z) =  (match./(size(Lpks, 1))*100);
% else
%     time_S(i,z) =  (match./(size(Rpks, 1))*100);
% end
% 
% k = k+2;
% 
% end
% 
%  k = 1;
%  
% for z = 1:9
% 
% time_corr(i,z) = corr(time_series(k,:)', time_series(k+1,:)');
% 
% k = k+2;
% end
% 


end








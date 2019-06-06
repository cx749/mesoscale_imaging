 function [num_peaks, still_period, spon_pks, spon_locs] = spon_after_stim(X_dff,movement_log,rest_len)

load('stim-movement-log');

trial_num = 20;%size(X_dff,1)./500;

k = 500-400; %sweep length 500 frames - where in sweep to start
d = 1;
l = 1;
time_moving = 0;

for i = 1:trial_num;
   %if stim_movement(i,:) == 0
    time_moving = time_moving + (sum(movement_log(:,k:(k+rest_len))));
    
    X = X_dff(k:(k+rest_len),:);
    X = low_filt(1,X);
    
    [pks,locs] = find_spon_peaks(X,movement_log);
   
    if locs > 0 
    locs = locs+k;
    
    spon_pks(d:(d+(size(pks,1)-1)),1) = pks(:,1);
    
    spon_locs(l:(l+(size(locs,1)-1)),1) = locs(:,1);
    
    k = k+499;
    d = d+size(pks,1);
    l = l+size(locs,1);
    
    else
    k = k+499;
    end
   %end  
end

exist spon_locs;

if ans > 0
num_peaks = size(spon_locs,1);
else 
num_peaks = 0;
   spon_pks = 0;
   spon_locs = 0;
end

still_period = (20*rest_len) - time_moving; %((20-sum(stim_movement))*rest_len) - time_moving;



end



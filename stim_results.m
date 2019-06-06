function [output] = stim_results(BW,roi)
load('stim-movement-log'); 
load ('individual respose traces');
load('individual max response traces');
load (roi)
%% Peak of each stim response
s = 1;
m = 1;

for i = (1:size(f,2));
    if stim_movement(i,:) == 0
    still(:,s) = f(:,i); 
    M_still(:,s) = max(f(:,i));   
    s=s+1;
    else
    moving(:,m) = f(:,i); 
    M_moving(:,m) = max(f(:,i));      
    m=m+1;
    end
end

s = 1;
m = 1;

for i = (1:size(max_f,2));
    if stim_movement(i,:) == 0
    still(:,s) = max_f(:,i); 
    max_M_still(:,s) = max(max_f(:,i));   
    s=s+1;
    else
    moving(:,m) = max_f(:,i); 
    max_M_moving(:,m) = max(max_f(:,i));      
    m=m+1;
    end
end


%% rise times
[max_dvdt_s,min_dvdt_s] = stim_rise_time(still);
exist moving; 
if ans > 0
[max_dvdt_m,min_dvdt_m] = stim_rise_time(moving);
else
end

%% area of activation (%)

area = ((sum(sum(threshIdx))./sum(sum(BW)))*100); % % that barrel area if of whole cortex


%% output matrix 
if ans > 0 
j = 4;
output(1,j) = mean(M_still); j = j+1; %average still stim max peak
output(1,j) = mean(M_moving); j = j+1; %average moving stim max peak
output(1,j) = mean(max_M_still); j = j+1; %max still stim max peak
output(1,j) = mean(max_M_moving); j = j+1; %max moving stim max peak
output(1,j) = max_dvdt_s; j = j+1; %average rise time still
output(1,j) = min_dvdt_s; j = j+1; %average decay time still
output(1,j) = max_dvdt_m; j = j+1; %average rise time moving
output(1,j) = min_dvdt_m; j = j+1; %average decay time moving
output(1,j) = area; j = j+1; %percentage area of activation
else
j = 4;
output(1,j) = mean(M_still); j = j+1; %average still stim max peak
output(1,j) = nan; j = j+1; %average moving stim max peak
output(1,j) = mean(max_M_still); j = j+1; %average still stim max peak
output(1,j) = nan; j = j+1; %average moving stim max peak
output(1,j) = max_dvdt_s; j = j+1; %average rise time still
output(1,j) = min_dvdt_s; j = j+1; %average decay time still
output(1,j) = nan; j = j+1; %average rise time moving
output(1,j) = nan; j = j+1; %average decay time moving
output(1,j) = area; j = j+1; %percentage area of activation
end
end
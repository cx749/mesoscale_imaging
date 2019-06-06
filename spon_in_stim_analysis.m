% **** load CSV file (import data)
% **** change name to data base
data_base = whiskertrimmedrecordings;  %developmentalrecordings; %
%%
ind=find(ismember(data_base(:,3),'D1 100ms')); %find location of stimulation (change name as needed) files in file record matrix

for i = 2:(size(ind,1)+1) %whisk sing P3 starts at 18
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory


if exist(fullfile(cd, 'movement-log.mat'), 'file') ==2 && exist(fullfile(cd, 'whole brain trace.mat'), 'file')

    load('movement-log');
B0 = linspace(500,10000,20); %end of each stim trial
stim_movement = zeros(20,1);

%Split timeseries into individual stim trials
for w = 1:20;
r1 = (B0(1,w)-499);
r2 = (B0(1,w)-475);
r3 = (B0(1,w)-1);

if sum(movement_log(:,r2:(r2+50))) > 0 %if movement during the 1 sec post stimlus
    stim_movement(w,1) = 1; 
else
     stim_movement(w,1) = 0; 
end
end
save ('stim-movement-log', 'stim_movement');

    
[output] = spon_peaks_in_stim (400,0); %chose length of time post stimulation and if ROI(0) or seedpixel (1) traces


%output(1,1) = ind(i-1,1);

spon_in_stim_results(i-1,:) = output; %output file into matrix of results;
%timings(i-1,:) = output;
else
  spon_in_stim_results(i-1,:) = nan; 
end

end
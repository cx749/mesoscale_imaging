data_base = developmentalrecordings; %whiskertrimmedrecordings; 
%%
ind=find(ismember(data_base(:,3),'20khz')); %find location of stimulation (change name as needed) files in file record matrix

for i = 24:(size(ind,1)+1) %whisk sing P3 starts at 18
cd (char(data_base(2,1))); %go to main root directory
cd(char(data_base((ind(i-1,1)),2))); %go to current file directory


load('right barrel trace');
load('movement-log');
[Xpks, Xlocs]  = find_spon_peaks(R_dff,movement_log);

r1 = 301;
r2 = 601;
for j = 1:19

period1 = [r1:r1+200];
period2 = [r2:r2+200];

outputbefore(i,j) = sum(ismember(period1,Xlocs));
outputafter(i,j) = sum(ismember(period2,Xlocs));

outputbtime(i,j) = 200-sum(movement_log(:,r1:r1+200));
outputatime(i,j) = 200-sum(movement_log(:,r2:r2+200));
timeratios(i,j) = outputatime(i,j)/outputbtime(i,j) ;

r1 = r1+500;
r2 = r2+500;
end

for k = 1:19
indiv_ratios(i,k) = (outputafter(i,k)/outputatime(i,k))/(outputbefore(i,k)/outputbtime(i,k));

end

before(i,:) = sum(outputbefore(i,:))/sum(outputbtime(i,:));
after(i,:) = sum(outputafter(i,:))/sum(outputatime(i,:));
ratios(i,:) = sum(outputafter(i,:))/sum(outputbefore(i,:));
ind_ratio(i,:) = mean(indiv_ratios(i,:));
timeratio(i,:) = mean(timeratios(i,:));
end

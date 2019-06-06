%% averaging movement 

Y = reshape(x, [1,(size(x,1))*(size(x,3))]);
trace_length = size(x,1)*(size(x,3)./20);

k = 1;
for i = 1:trace_length
    movement(1,i) = mean(Y(1,k:k+19));
    %if k < 199980
    k = k+20;
    %end
end
movement = movement.*100;

 
save ('movement_averaged','movement');

%% create movement envelope
k = envelope(movement,10,'rms');
ks = low_filt(1,k);

th=0.06;

figure;plot(movement);hold;plot(ks);


save ('movement-envelope', 'ks');

%% manually determine threshold that movement is over
%th=...

%% create movement log

movement_log = zeros(1,(size(ks,2)));
for i = 1:size(ks,2);
    if ks(1,i) > th
        movement_log(:,i) = 1;
    else
         movement_log(:,i) = 0;
end
end

figure;bar(movement_log);hold;plot(ks);
%%
save ('movement-log', 'movement_log');


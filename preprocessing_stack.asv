function I = preprocessing_stack(I,mean_lows,high,low,type)


I = double(I);
if strcmpi('butter',type)
%baseline correct and temporally filter with butterworth 
for i = 1:size(I,1)
    for j = 1:size(I,2)
I(i,j,:) = (I(i,j,:) - mean_lows(i,j))./mean_lows(i,j)*100;
I(i,j,:) = low_filt(low,I(i,j,:));
I(i,j,:) = high_filt(high,I(i,j,:));
    end
end
elseif strcmpi('cheby',type)
    fprintf('cheby filtering')
        for i = 1:size(I,1)
    for j = 1:size(I,2)
I(i,j,:) = (I(i,j,:) - mean_lows(i,j))./mean_lows(i,j)*100;
I(i,j,:) = cheby_band_filt(high,low,I(i,j,:));

    end
end
    else 
        error 'Unknown filter type specified'

    end
end

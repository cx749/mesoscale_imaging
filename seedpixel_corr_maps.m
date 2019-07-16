function [seedpixel_corr_map] = seedpixel_corr_maps(pixel, I)


seed_trace = reshape(I(pixel(1,2), pixel(1,1),:),1,size(I,3));


for i = 1:size(I,1)
    for j = 1:size(I,2)
        current_trace = reshape(I(i,j,:),1,size(I,3));
        correl = corrcoef(current_trace, seed_trace); 
        seedpixel_corr_map(i,j) = correl(2,1);
    end
end
% 
% figure; imagesc(seedpixel_corr_map);
function [matches,motifs,motif_pks,motif_locs] = motif_correlation(I,barrel_map,threshold)

for i = 1:size(I,3)
    frame = I(:,:,i);
    correl = corrcoef(barrel_map,frame);
    matches(1,i) = correl(2,1);
   
end
% figure;imagesc(matches);colormap(jet);colorbar;


thresh = max(matches).*threshold;
high_matches = matches-thresh;

high_matches(high_matches<0) = 0;

[motif_pks,motif_locs] = findpeaks(high_matches); 

for j = 1:size(motif_locs,2)
   motifs(:,:,j) = I(:,:,motif_locs(:,j));
end

end

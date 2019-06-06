function [match] = matched_peaks(R,Xpks,Xlocs,RpksR,Rlocs)
%R = range in frames that have to cooactivate within

if size(Xlocs,1) < size(Rlocs,1)
    corr = 0;
    for i = 1:size(Rlocs,1);
    
    a = (Rlocs(i,:)-R);
    b = (Rlocs(i,:)+R);
    
    member = Xlocs(:,:) > a & Xlocs(:,:) < b;
    
    if sum(member) > 0
        
        corr = corr+1;
      
    else
        
    end
    end
else
    
    corr = 0;
    for i = 1:size(Xlocs,1);
    
    a = (Xlocs(i,:)-R);
    b = (Xlocs(i,:)+R);
    
    member = Rlocs(:,:) > a & Rlocs(:,:) < b;
    
    if sum(member) > 0
        
        corr = corr+1;
      
    else
        
    end
end

end


match = corr;
%end

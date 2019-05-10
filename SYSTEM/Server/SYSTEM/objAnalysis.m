function objAnalysis(image, labels, id, plots)
    if ~exist('plots', 'var'), plots = 0; end
    

    rp = regionprops(labels==id, 'all');
    bb = ceil(rp.BoundingBox);
    im = image;
    
    for k = 1:3
        sd=im(:,:,k); sd(labels~=id)=0; im(:,:,k) = sd; 
    end
    
    ou = im(bb(2):bb(2)+bb(4)-1, bb(1):bb(1)+bb(3)-1, :);
    subplot(2, 1, 1); imagesc(ou); title(id); axis image;
    ou(ou==0) = NaN;
    
end
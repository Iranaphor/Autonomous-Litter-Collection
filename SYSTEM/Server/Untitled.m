
y = (a2(:,:,2) - a2(:,:,3)) > 0.27; 
b = (a2(:,:,3) - a2(:,:,2)) > 0.15; 
r = (a2(:,:,1) - (a2(:,:,2) + a2(:,:,2))> 0.26); 

im = bwlabel(bwmorph(imerode(bwmorph(imfill(y+r+b, 'holes'), 'majority'), ones(10)), 'shrink', Inf));

imagesc(im);




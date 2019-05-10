%Extract the foreground objects
function [labels, objects] = foregroundExtraction(frame, bg)
    fprintf('Object Extraction\n');
    a = frame~=bg;
    a = permute(  max(  permute(a, [3, 1, 2])   )   , [2, 3, 1]);
    labels = bwlabel(imfill(imdilate(a, ones(3)),'holes'));

    for i = 1:max(max(labels))
        t1 = rgb2gray(frame);
        t1( labels ~= i ) = 0;
        objects(:,:,i) = t1;
    end

end